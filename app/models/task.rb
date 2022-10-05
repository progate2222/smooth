class Task < ApplicationRecord
    enum importance: { "高": 1, "中": 2, "低": 3 }
    belongs_to :user
    has_many :requests, dependent: :destroy
    accepts_nested_attributes_for :requests, allow_destroy: true, reject_if: :all_blank
end
