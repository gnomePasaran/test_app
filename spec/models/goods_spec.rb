require 'rails_helper'

RSpec.describe Goods, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :date }
  it { should validate_presence_of :revenue }

  it { should validate_uniqueness_of(:title).scoped_to(:date) }
end
