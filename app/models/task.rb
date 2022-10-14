class Task < ApplicationRecord
    validates :title, presence: true
    validates :time_limit, presence: true
    enum importance: { 高: 1, 中: 2, 低: 3 }

    belongs_to :user
    belongs_to :team
    has_many :requests, dependent: :destroy
    accepts_nested_attributes_for :requests, allow_destroy: true, reject_if: :successor_blank

    def successor_blank(attributes)
        attributes[:successor_id].blank?
    end

end
