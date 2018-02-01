class GoodsController < ApplicationController
  respond_to :json

  def index
    validation = date_validation
    return respond_with( validation , status: 422) if validation != true

    @goods = Goods.from_to(params[:from], params[:to])
    respond_with serialized_goods
  end

  private

  def date_validation
    return { error: t('.no_date') } if params[:from].blank? && params[:to].blank?
    begin
      Date.parse(params[:from])
      Date.parse(params[:to])
    rescue StandardError => error
      return { error: error }
    end
    return { error: t('.wrong_sequence') } if params[:from] > params[:to]
    true
  end

  def serialized_goods
    {
      from: params[:from],
      to: params[:to],
      goods: ActiveModel::ArraySerializer.new(@goods).as_json,
      total_revenue: @goods.sum(:revenue)
    }
  end
end
