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

    # describe '管理者権限のテスト' do
    #     before do
    #         visit new_user_session_path
    #         fill_in "user_email", with: 'user_admin@mail.com'
    #         fill_in "user_password", with: 'user_admin'
    #         find('#login').click
    #         visit rails_admin_path
    #     end

    #     context '管理ユーザは' do
    #         it 'ユーザーを新規作製できる(Create)' do
    #             click_on(all(".nav-link")[5])
    #             click_on('新規登録')
    #             fill_in "user_email", with: 'test@mail.com'
    #             fill_in "user_password", with: '111111'
    #             fill_in "user_password_confirmation", with: '111111'
    #             fill_in "user_name", with: 'test'
    #             click_on('保存')
    #             expect(page).to have_content 'ユーザーの作成に成功しました'
    #         end
    #     end
    # end

end
