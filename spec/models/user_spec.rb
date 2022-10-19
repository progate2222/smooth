require 'rails_helper'
describe 'ユーザーモデル機能', type: :model do
    let!(:user) { FactoryBot.create(:user) }

    describe 'バリデーションのテスト' do
        context 'ユーザーの名前が空の場合' do
            it 'バリデーションにひっかる' do
            user = User.new(name: '', email:"test@email.com", password:"111111")
            expect(user).not_to be_valid
            end
        end

        context 'ユーザーの名前が入力されている場合' do
            it 'バリデーションが通る' do
            user = User.new(name: 'test', email:"test@email.com", password:"111111")
            expect(user).to be_valid
            end
        end
    end

end
