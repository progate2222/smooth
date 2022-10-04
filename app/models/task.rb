class Task < ApplicationRecord
    belongs_to :user
    has_many :requests, dependent: :destroy
    accepts_nested_attributes_for :requests, allow_destroy: true, reject_if: :all_blank
end
