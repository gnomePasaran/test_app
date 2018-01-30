class Goods < ApplicationRecord
  validates :title, :date, :revenue, presence: true
  validates :title, uniqueness: { scope: :date }
end
