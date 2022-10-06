class Task < ApplicationRecord
    enum importance: { "高": 1, "中": 2, "低": 3 }
    belongs_to :user
    belongs_to :team
    has_many :requests, dependent: :destroy
    accepts_nested_attributes_for :requests, allow_destroy: true, reject_if: :reject_predecessor_id

    def reject_predecessor_id(attributes)
        attributes.except(:predecessor_id).values.all?(&:blank?)
    end

end
