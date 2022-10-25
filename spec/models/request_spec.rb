require 'rails_helper'
describe 'リクエストモデル機能', type: :model do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:admin_user) }
    let!(:team) { FactoryBot.create(:team) }

    describe 'バリデーションのテスト' do
        context '申し送りのメッセージが200文字を超える場合' do
            it 'バリデーションにひっかる' do
                task = Task.new(title: 'タイトル', time_limit: '2022-12-01 19:00:00', user: user, team: team)
                request = Request.new(message:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                                    user: user,
                                                    successor_id: user2.id,
                                                    task: task)
                expect(request).not_to be_valid
            end
        end
        context '申し送りのメッセージが200文字以内の場合' do
            it 'バリデーションが通る' do
                task = Task.new(title: 'タイトル', time_limit: '2022-12-01 19:00:00', user: user, team: team)
                request = Request.new(message:'200文字以内のメッセージ',
                                                    user: user,
                                                    successor_id: user2.id,
                                                    task: task)
                expect(request).to be_valid
            end
        end
    end

end
