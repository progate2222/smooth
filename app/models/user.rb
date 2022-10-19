class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
  has_many :tasks
  has_many :requests
  has_many :team_members, dependent: :destroy
  has_many :team_member_teams, through: :team_members, source: :team

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.name = "ゲスト（アドミン）"
      user.password = SecureRandom.urlsafe_base64
      user.admin = true
    end
  end

end
