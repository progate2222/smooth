class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
  has_many :tasks
  has_many :requests
  has_many :team_members, dependent: :destroy
  has_many :team_member_teams, through: :team_members, source: :team
end
