require 'rails_helper'

describe 'Sales API', type: :request do
  let!(:goods) { create_pair(:goods, date: '2017-03-03') }

  describe 'GET /index' do
    context 'valid request' do
      before { get '/sales', params: { from: '2017-03-03', to: '2017-03-03', format: :json } }

      it 'returns status 200' do
        expect(response.status).to eq 200
      end

      it 'returns serialized_goods list' do
        expect(response.body).to have_json_size(4)
      end

      %w(title revenue).each do |attr|
        it "goods object contains #{attr}" do
          goods.each_with_index do |goods, index|
            expect(response.body).to be_json_eql(goods.send(attr.to_sym).to_json).at_path("goods/#{index}/#{attr}")
          end
        end
      end
    end

    context 'invalid request' do
      it 'returns status 422' do
        get '/sales', params: { format: :json }
        expect(response.status).to eq 422
      end

      it 'returns date absent message' do
        get '/sales', params: { format: :json }
        expect(response.body).to be_json_eql(I18n::t('goods.index.no_date').to_json).at_path('error')
      end

      it 'returns wrong sequence message' do
        get '/sales', params: { from: '2017-03-04', to: '2017-03-03', format: :json }
        expect(response.body).to be_json_eql(I18n::t('goods.index.wrong_sequence').to_json).at_path('error')
      end

      it 'returns invalid date message' do
        get '/sales', params: { from: '20179999', to: '0103-03', format: :json }
        expect(response.body).to be_json_eql('invalid date'.to_json).at_path('error')
      end
    end
  end
end
