require 'rails_helper'

RSpec.describe Goods, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :date }
  it { should validate_presence_of :revenue }

  it { should validate_uniqueness_of(:title).scoped_to(:date) }

  describe '.from_to' do
    let(:from) { '2017-03-02'.to_date }
    let(:to) { '2017-03-03'.to_date }
    let!(:goods) { create_pair(:goods, date: from) }
    let!(:goods1) { create_pair(:goods, date: to) }
    let!(:goods2) { create_pair(:goods, date: from - 1.day) }
    let!(:goods3) { create_pair(:goods, date: to + 1.day) }

    before { goods1.map { |g| goods << g } }

    it 'returns goods in period' do
      expect(Goods.from_to(from, to)).to eq goods
    end
    it 'not returns goods before period' do
      expect(Goods.from_to(from, to)).not_to include goods2
    end
    it 'not returns goods after period' do
      expect(Goods.from_to(from, to)).to_not include goods3
    end
  end
end
