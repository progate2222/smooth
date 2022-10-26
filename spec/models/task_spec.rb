require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:team) { FactoryBot.create(:team) }

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', time_limit: '2022-12-01 19:00:00', user: user, team: team)
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
        task = Task.new(title: '失敗テスト', time_limit: '2022-12-01 19:00:00', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと期日とチームidに内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', time_limit: '2022-12-01 19:00:00', user: user, team: team)
        expect(task).to be_valid
      end
    end
    context 'タスクの期日が過去の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', time_limit: '2000-10-01 19:00:00', user: user, team: team)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの期日が未来日の場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', time_limit: '2030-12-01 19:00:00', user: user, team: team)
        expect(task).to be_valid
      end
    end
    context 'タスクのタイトルが30文字を超えた場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめも', time_limit: '2030-10-01 19:00:00', user: user, team: team)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が300文字を超えた場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト',
                                  description: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                  time_limit: '2022-12-01 19:00:00', user: user, team: team)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が300文字以内の場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト',
                                  description: '300文字以内のタイトル',
                                  time_limit: '2022-12-01 19:00:00', user: user, team: team)
        expect(task).to be_valid
      end
    end
    context 'タスクのメモが200文字を超えた場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト',
                                  memo: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                  time_limit: '2022-12-01 19:00:00', user: user, team: team)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのメモが200文字以内の場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト',
                                  memo: '200文字以内のメモ',
                                  time_limit: '2022-12-01 19:00:00', user: user, team: team)
        expect(task).to be_valid
      end
    end
  end

end
