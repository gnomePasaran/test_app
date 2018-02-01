Rails.application.routes.draw do
  get :sales, to: 'goods#index'
end
