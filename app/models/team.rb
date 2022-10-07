class Team < ApplicationRecord
    has_many :team_members, dependent: :destroy
    has_many :team_member_users, through: :team_members, source: :user
    has_many :tasks
end
