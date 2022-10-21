require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin_user) {  FactoryBot.create(:admin_user) }

    describe 'ログイン機能のテスト' do
        context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
            it 'トップページに遷移する' do
                visit tasks_path
                expect(page).to have_content 'smooth を使ってできること'
            end
        end
    end

    describe 'セッション機能のテスト' do
        before do
            visit new_user_session_path
            fill_in "user_email", with: 'user_general@mail.com'
            fill_in "user_password", with: 'user_general'
            find('#login').click
        end

        context 'ログインページから情報を入力し' do
            it 'ログインができる' do
                expect(page).to have_content 'タスク一覧'
            end
        end

        context 'ユーザがログインした後に' do
            it '自分の詳細画面(マイページ)に飛べる' do
                click_on('マイページ')
                expect(page).to have_content 'user_generalのページ'
            end
        end

        context '一般ユーザが他人の詳細画面に飛ぶと' do
            it 'タスク一覧画面に遷移する(アクセス制限に関するテスト)' do
                visit user_path(admin_user)
                expect(page).to have_content 'タスク一覧'
            end
        end

        context 'ユーザがログインした後に' do
            it 'ログアウトができる' do
                click_on('ログアウト')
                expect(page).to have_content 'ログインもしくはアカウント登録してください。'
            end
        end
    end

    describe '管理者権限のテスト' do
        before do
            visit new_user_session_path
            fill_in "user_email", with: 'user_admin@mail.com'
            fill_in "user_password", with: 'user_admin'
            find('#login').click
            visit rails_admin_path
        end

        context '管理ユーザは' do
            it 'ユーザーを新規作製できる(Create)' do
                sleep 1.0
                page.all(".nav-link")[8].click
                sleep 1.0
                page.all(".nav-link")[10].click
                fill_in "user_email", with: 'test@mail.com'
                fill_in "user_password", with: '111111'
                fill_in "user_password_confirmation", with: '111111'
                fill_in "user_name", with: 'test'
                click_on('保存')
                expect(page).to have_content 'ユーザーの作成に成功しました'
            end
            it 'ユーザーの詳細を確認できる(Read)' do
                sleep 1.0
                page.all(".nav-link")[8].click
                sleep 1.0
                page.all(".show_member_link").last.click
                expect(page).to have_content "ユーザー 'user_general'の詳細"
            end
            it 'ユーザーを編集できる(Update)' do
                sleep 1.0
                page.all(".nav-link")[8].click
                sleep 1.0
                page.all(".fa-pencil-alt")[1].click
                fill_in "user_name", with: 'Update_user'
                click_on('保存')
                expect(page).to have_content 'ユーザーの更新に成功しました'
            end
            it 'ユーザーを削除できる(Destroy)' do
                sleep 1.0
                page.all(".nav-link")[8].click
                sleep 1.0
                page.all(".fa-times").last.click
                click_on('実行する')
                expect(page).to have_content 'ユーザーの削除に成功しました'
            end
        end

        context '管理ユーザは' do
            it 'チームを新規作製できる(Create)' do
                sleep 1.0
                page.all(".nav-link")[5].click
                sleep 1.0
                page.all(".nav-link")[10].click
                fill_in "team_name", with: 'テストチーム'
                click_on('保存')
                expect(page).to have_content 'Teamの作成に成功しました'
            end
            it 'チームの詳細を確認できる(Read)' do
                sleep 1.0
                page.all(".nav-link")[5].click
                sleep 1.0
                page.all(".nav-link")[10].click
                fill_in "team_name", with: 'テストチーム'
                click_on('保存')
                sleep 1.0
                page.all(".nav-link")[5].click
                sleep 1.0
                page.all(".fa-info-circle").last.click
                expect(page).to have_content "Team 'テストチーム'の詳細"
            end
            it 'チームを編集できる(Update)' do
                sleep 1.0
                page.all(".nav-link")[5].click
                sleep 1.0
                page.all(".nav-link")[10].click
                fill_in "team_name", with: 'テストチーム'
                click_on('保存')
                sleep 1.0
                page.all(".fa-pencil-alt").last.click
                fill_in "team_name", with: 'Update_team'
                click_on('保存')
                expect(page).to have_content 'Teamの更新に成功しました'
            end
            it 'チームを削除できる(Destroy)' do
                sleep 1.0
                page.all(".nav-link")[5].click
                sleep 1.0
                page.all(".nav-link")[10].click
                fill_in "team_name", with: 'テストチーム'
                click_on('保存')
                sleep 1.0
                page.all(".fa-times").last.click
                click_on('実行する')
                expect(page).to have_content 'Teamの削除に成功しました'
            end
        end

        context '管理ユーザは' do
            it 'チームメンバーを新規作製できる(Create)' do
                sleep 1.0
                page.all(".nav-link")[6].click
                sleep 1.0
                page.all(".nav-link")[10].click
                click_on('新規ユーザー追加')
                sleep 1.0
                fill_in "user_email", with: 'test@mail.com'
                fill_in "user_password", with: '111111'
                fill_in "user_password_confirmation", with: '111111'
                fill_in "user_name", with: 'test'
                page.all(".save-action").last.click
                sleep 1.0
                click_on('新規Team追加')
                fill_in "team_name", with: 'テストチーム'
                sleep 1.0
                page.all(".save-action").last.click
                sleep 1.0
                click_on('保存')
                expect(page).to have_content 'Team memberの作成に成功しました'
            end
            it 'チームメンバーの詳細を確認できる(Read)' do
                sleep 1.0
                page.all(".nav-link")[6].click
                sleep 1.0
                page.all(".nav-link")[10].click
                click_on('新規ユーザー追加')
                sleep 1.0
                fill_in "user_email", with: 'test@mail.com'
                fill_in "user_password", with: '111111'
                fill_in "user_password_confirmation", with: '111111'
                fill_in "user_name", with: 'test'
                page.all(".save-action").last.click
                sleep 1.0
                click_on('新規Team追加')
                fill_in "team_name", with: 'テストチーム'
                sleep 1.0
                page.all(".save-action").last.click
                sleep 1.0
                click_on('保存')
                sleep 1.0
                page.all(".nav-link")[6].click
                sleep 1.0
                page.all(".fa-info-circle").first.click
                expect(page).to have_content "Team member 'TeamMember #"
                expect(page).to have_content "の詳細"
            end
            it 'チームメンバーを編集できる(Update)' do
                sleep 1.0
                page.all(".nav-link")[6].click
                sleep 1.0
                page.all(".nav-link")[10].click
                click_on('新規ユーザー追加')
                sleep 1.0
                fill_in "user_email", with: 'test@mail.com'
                fill_in "user_password", with: '111111'
                fill_in "user_password_confirmation", with: '111111'
                fill_in "user_name", with: 'test'
                page.all(".save-action").last.click
                sleep 1.0
                click_on('新規Team追加')
                fill_in "team_name", with: 'テストチーム'
                sleep 1.0
                page.all(".save-action").last.click
                sleep 1.0
                click_on('保存')
                sleep 1.0
                page.all(".fa-pencil-alt").last.click
                click_on('新規Team追加')
                fill_in "team_name", with: 'テストチーム2'
                sleep 1.0
                page.all(".save-action").last.click
                sleep 1.0
                click_on('保存')
                expect(page).to have_content 'Team memberの更新に成功しました'
            end
            it 'チームメンバーを削除できる(Destroy)' do
                sleep 1.0
                page.all(".nav-link")[6].click
                sleep 1.0
                page.all(".nav-link")[10].click
                click_on('新規ユーザー追加')
                sleep 1.0
                fill_in "user_email", with: 'test@mail.com'
                fill_in "user_password", with: '111111'
                fill_in "user_password_confirmation", with: '111111'
                fill_in "user_name", with: 'test'
                page.all(".save-action").last.click
                sleep 1.0
                click_on('新規Team追加')
                fill_in "team_name", with: 'テストチーム'
                sleep 1.0
                page.all(".save-action").last.click
                sleep 1.0
                click_on('保存')
                sleep 1.0
                page.all(".fa-times").last.click
                click_on('実行する')
                expect(page).to have_content 'Team memberの削除に成功しました'
            end
        end

    end

end
