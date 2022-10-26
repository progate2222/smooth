FactoryBot.define do

  factory :task do
    title { 'Factoryで作ったタスク名1' }
    description { '詳細' }
    time_limit { '2030-10-31 19:00:00' }
    importance { '高' }
    memo { '詳細画面で確認できるメモ' }
  end

  factory :task2, class: Task do
    title { 'Factoryで作ったタスク名2' }
    description { '詳細' }
    time_limit { '2030-10-01 19:00:00' }
    importance { '低' }
    memo { '詳細画面で確認できるメモ' }
  end

  factory :task3, class: Task do
    title { 'Factoryで作ったタスク名2' }
    description { '詳細' }
    time_limit { '2030-10-01 19:00:00' }
    importance { '低' }
    memo { '詳細画面で確認できるメモ' }
    completion_flag { 'true' }
  end

end
