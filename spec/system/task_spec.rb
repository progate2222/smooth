require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
let!(:user) { FactoryBot.create(:user) }
let!(:admin_user) { FactoryBot.create(:admin_user) }
let!(:team) { FactoryBot.create(:team) }
let!(:task) { FactoryBot.create(:task, user: user, team: team) }

    describe 'タスクのCRAD機能' do
        before do
            visit new_user_session_path
            fill_in "user_email", with: 'user_general@mail.com'
            fill_in "user_password", with: 'user_general'
            find('#login').click
        end
        context 'タスクを新規登録画面で' do
            it 'タスクを作製できる(Create)' do
                visit new_task_path
                fill_in "task_title", with: 'タスク'
                fill_in "task_description", with: 'タスクの詳細'
                fill_in "task_time_limit", with: '002030-10-31T19:00:00'
                select 'Factoryで作ったチーム1', from: 'task_team_id'
                click_on('登録する')
                expect(page).to have_content '投稿者: user_general'
            end
        end
        context '任意のタスク詳細画面に遷移した場合' do
            it '該当タスクの内容が表示される(Read)' do
                visit tasks_path
                click_on('詳細')
                expect(page).to have_content '詳細画面で確認できるメモ'
            end
        end
        context '任意のタスク編集画面に遷移した場合' do
            it '該当タスクの内容を編集することができる(Update)' do
                visit tasks_path
                click_on('編集')
                fill_in "task_title", with: '編集したタスク'
                click_on('更新する')
                expect(page).to have_content '編集したタスク'
            end
        end
        context '任意のタスクの削除ボタンを押した場合' do
            it '該当タスクの削除できる(Delete)' do
                visit tasks_path
                click_on('削除')
                page.driver.browser.switch_to.alert.accept
                expect(page).not_to have_content 'Factoryで作ったタスク名1'
            end
        end
    end

    describe '申し送り機能' do
        before do
            visit new_user_session_path
            fill_in "user_email", with: 'user_general@mail.com'
            fill_in "user_password", with: 'user_general'
            find('#login').click
        end
        context 'タスクを新規登録するとき' do
            it '申し送り情報も登録できる' do
                visit new_task_path
                fill_in "task_title", with: 'タスク'
                fill_in "task_description", with: 'タスクの詳細'
                fill_in "task_time_limit", with: '002030-10-31T19:00:00'
                select 'Factoryで作ったチーム1', from: 'task_team_id'
                fill_in "task_requests_attributes_0_message", with: '申し送りメッセージ'
                select 'user_admin', from: 'task_requests_attributes_0_successor_id'
                click_on('登録する')
                expect(page).to have_content '投稿者: user_general'
                expect(page).to have_content 'user_admin'
            end
        end
            context 'タスクを編集するとき' do
            it '申し送り情報も登録できる' do
                visit tasks_path
                click_on('編集')
                fill_in "task_requests_attributes_0_message", with: '申し送りメッセージ'
                select 'user_admin', from: 'task_requests_attributes_0_successor_id'
                click_on('更新する')
                expect(page).to have_content '申し送りメッセージ'
            end
        end
        context 'タスクを申し送りすると' do
            it '後任者のマイページにタスクが表示される' do
                visit tasks_path
                click_on('編集')
                fill_in "task_requests_attributes_0_message", with: '申し送りメッセージ'
                select 'user_admin', from: 'task_requests_attributes_0_successor_id'
                click_on('更新する')
                click_on('マイページ')
                expect(page).not_to have_content 'Factoryで作ったタスク名1'
                click_on('ログアウト')
                visit new_user_session_path
                fill_in "user_email", with: 'user_admin@mail.com'
                fill_in "user_password", with: 'user_admin'
                find('#login').click
                click_on('マイページ')
                expect(page).to have_content 'Factoryで作ったタスク名1'
            end
        end
        context 'タスクを申し送りすると' do
            it '後任者にメールが送信される' do
                expect {
                    visit tasks_path
                    click_on('編集')
                    fill_in "task_requests_attributes_0_message", with: '申し送りメッセージ'
                    select 'user_admin', from: 'task_requests_attributes_0_successor_id'
                    click_on('更新する')
                }.to change { ActionMailer::Base.deliveries.size }.by(1)
            end
        end
    end

    describe '一覧表示機能' do
        let!(:task2) { FactoryBot.create(:task2, user: user, team: team) }
        before do
            visit new_user_session_path
            fill_in "user_email", with: 'user_general@mail.com'
            fill_in "user_password", with: 'user_general'
            find('#login').click
        end
        context '一覧画面に遷移した場合' do
            it '作成済みのタスク一覧が表示される' do
                visit tasks_path
                expect(page).to have_content 'Factoryで作ったタスク名1'
            end
        end
        context 'タスクが期日の昇順に並んでいる場合' do
            it '期日が一番近いタスクが一番上に表示される' do
                visit tasks_path
                task_list = all('.task_row')
                expect(task_list[0]).to have_content 'Factoryで作ったタスク名2'
                expect(task_list[1]).to have_content 'Factoryで作ったタスク名1'
            end
        end
        context '重要度のリンクを押すと' do
            it '重要度が高い順にタスク一覧が表示される' do
                visit tasks_path
                click_on('重要度')
                task_list = all('.task_row')
                expect(find_by_id('task_0')).to have_content 'Factoryで作ったタスク名1'
                expect(find_by_id('task_1')).to have_content 'Factoryで作ったタスク名2'
            end
        end
        context 'タイトルであいまい検索をした場合' do
            it "検索キーワードを含むタスクで絞り込まれる" do
                visit tasks_path
                fill_in "q_title_cont", with: 'タスク名1'
                click_on('検索')
                expect(page).to have_content 'タスク名1'
                expect(page).not_to have_content 'タスク名2'
            end
        end
    end

end
