# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


teams = Team.create!([
    { name: "経理部" },
    { name: "人事部" },
    { name: "営業部" },
    { name: "総務部" },
    { name: "掃除部" },
])

    admin = User.create!({ name: "田村", email: "tamura@mail.com", password: 'tamura', admin: true })

    users = User.create!([
        { name: "キム", email: "kim@mail.com", password: 'kimkim', admin: false },
        { name: "もとや", email: "motoya@mail.com", password: 'motoya', admin: false },
        { name: "まなみ", email: "manami@mail.com", password: 'manami', admin: false },
        { name: "あゆみ", email: "ayumi@mail.com", password: 'ayumi1', admin: false },
        { name: "大塚", email: "ootsuka@mail.com", password: 'ootsuka', admin: false },
        { name: "アベマツ", email: "abematsu@mail.com", password: 'abematsu', admin: false },
        { name: "ゲスト", email: "guest@example.com", password: 'guest1', admin: false },
        { name: "ゲスト（アドミン）", email: "guest_admin@example.com", password: 'guestadmin', admin: true }
    ])

    TeamMember.create!([
        { user_id: admin.id, team_id: teams[0].id },
        { user_id: admin.id, team_id: teams[1].id },
        { user_id: admin.id, team_id: teams[2].id },
        { user_id: admin.id, team_id: teams[3].id },
        { user_id: admin.id, team_id: teams[4].id },
        { user_id: users[0].id, team_id: teams[4].id },
        { user_id: users[1].id, team_id: teams[0].id },
        { user_id: users[1].id, team_id: teams[4].id },
        { user_id: users[2].id, team_id: teams[1].id },
        { user_id: users[3].id, team_id: teams[2].id },
        { user_id: users[4].id, team_id: teams[3].id },
        { user_id: users[5].id, team_id: teams[4].id },
        { user_id: users[6].id, team_id: teams[3].id },
        { user_id: users[7].id, team_id: teams[3].id },
    ])

    tasks = Task.create!([
        { title: "会議室の掃除",
            description: "塵一つ残さずピカピカにする",
            time_limit: Time.parse('2030-10-01 19:00:00'),
            importance: '中',
            completion_flag: false,
            memo: "ゴミ箱もチェックする",
            user: admin,
            team:teams[4] },
        { title: "四半期決算",
            description: "9月締めで決算を行う。",
            time_limit: Time.parse('2030-11-30 19:00:00'),
            importance: '高',
            completion_flag: false,
            memo: "営業さんから経費のレシートも回収する",
            user: users[1],
            team:teams[0] },
        { title: "人事評価",
            description: "全社員の上半期の評価を行う",
            time_limit: Time.parse('2030-10-31 19:00:00'),
            importance: '高',
            completion_flag: false,
            memo: "評価チェックシートは最新のものを使う",
            user: users[2],
            team:teams[1] },
        { title: "取引先へのあいさつ回り",
            description: "○○会社と▽▽会社へ伺う",
            time_limit: Time.parse('2030-11-15 19:00:00'),
            importance: '中',
            completion_flag: false,
            memo: "手土産はお饅頭",
            user: users[3],
            team:teams[2] },
        { title: "受付のお花を変える",
            description: "■■花屋に発注",
            time_limit: Time.parse('2030-10-10 19:00:00'),
            importance: '低',
            completion_flag: true,
            memo: "予算は3000円",
            user: users[4],
            team:teams[3] },
        { title: "加湿器の準備",
            description: "備品室の加湿器を出す",
            time_limit: Time.parse('2030-11-10 19:00:00'),
            importance: '中',
            completion_flag: false,
            memo: "5台あり。",
            user: users[4],
            team:teams[3] },
        { title: "ゲストのタスク",
            description: "",
            time_limit: Time.parse('2030-10-01 19:00:00'),
            importance: '低',
            completion_flag: true,
            memo: "",
            user: users[6],
            team:teams[3] },
        { title: "ゲスト（アドミン）のタスク",
            description: "",
            time_limit: Time.parse('2030-10-01 19:00:00'),
            importance: '低',
            completion_flag: true,
            memo: "",
            user: users[7],
            team:teams[3] }
    ])

    Request.create!([
        { message: "掃除が終わらなかったので続きをお願いします",
            successor_id: users[0].id,
            task: tasks[0],
            user: admin },
        { message: "窓を拭き忘れたのでお願いします",
            successor_id: users[5].id,
            task: tasks[0],
            user: users[0] },
        { message: "ゴミ箱を見るの忘れたのでお願いします",
            successor_id: users[1].id,
            task: tasks[0],
            user: users[5] },
        { message: "▽▽会社への訪問お願いします",
            successor_id: users[5].id,
            task: tasks[3],
            user: users[3] },
        { message: "残り2台出しておいてください",
            successor_id: admin.id,
            task: tasks[5],
            user: users[4] }
    ])

