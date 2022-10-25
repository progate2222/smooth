class Task < ApplicationRecord
    validates :title, presence: true, length: { maximum: 30 }
    validates :description, length: { maximum: 300 }
    validates :time_limit, presence: true
    validates :memo, length: { maximum: 200 }
    validate :time_limit_check
    enum importance: { 高: 1, 中: 2, 低: 3 }

    belongs_to :user
    belongs_to :team
    has_many :requests, dependent: :destroy
    accepts_nested_attributes_for :requests, allow_destroy: true, reject_if: :successor_blank

    def successor_blank(attributes)
        attributes[:successor_id].blank?
    end

    def time_limit_check
        errors.add(:time_limit, "は登録必須です。過去の日付は登録できません。") if self.time_limit == nil || (self.time_limit < DateTime.current)
    end

end
