require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:team) { FactoryBot.create(:team) }

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', time_limit: '2022-10-01 19:00:00', user: user, team: team)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの期日が空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '失敗テスト', time_limit: '', user: user, team: team)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのチームidが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '失敗テスト', time_limit: '2022-10-01 19:00:00', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと期日とチームidに内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', time_limit: '2022-10-01 19:00:00', user: user, team: team)
        expect(task).to be_valid
      end
    end
  end

end
