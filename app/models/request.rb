class Request < ApplicationRecord
    validates :successor_id, presence: true
    validates :message, length: { maximum: 200 }
    belongs_to :task
    belongs_to :user
end
