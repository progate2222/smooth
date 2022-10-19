# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
    n += 1
    User.create!(
        name: "seed_ユーザー#{n}",
        email: "seed_user#{n}@mail.com",
        password: '111111',
        admin: false
    )

    Team.create!(
        name: "チーム#{n}",
    )

    Task.create!(
        title: "seed_タスク#{n}",
        description: "seed_タスク#{n}の詳細",
        time_limit: Time.parse('2022-10-31 19:00:00'),
        importance: '高',
        completion_flag: false,
        memo: "seed_タスク#{n}のメモ",
        user_id: 1,
        team_id: 1
    )

    Request.create!(
        message: "申し送り#{n}",
        successor_id: 2,
        task_id: 1,
        user_id: 1
    )
end
