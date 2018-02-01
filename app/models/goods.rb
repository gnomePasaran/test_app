class Goods < ApplicationRecord
  validates :title, :date, :revenue, presence: true
  validates :title, uniqueness: { scope: :date }

  scope :from_to,
    -> (from, to) { where('date >= :from AND date <= :to', from: from, to: to) }
end
