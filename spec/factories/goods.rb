FactoryBot.define do
  sequence :title do |n|
    "Title#{n}"
  end
  factory :goods do
    title
    date Date.current
    revenue 35000.00
  end
end
