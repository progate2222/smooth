class Request < ApplicationRecord
    validates :successor_id, presence: true
    belongs_to :task
    belongs_to :user
end
