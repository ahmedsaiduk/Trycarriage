Rails.application.routes.draw do
  post 'api/transactions/sq_ft', to: 'api/transactions#sq_ft_range', via: :post
  post 'api/transactions/price', to: 'api/transactions#price_range', via: :post
  post 'api/transactions/type', to: 'api/transactions#type_filter', via: :post
  get 'api/transactions', to: 'api/transactions#all_record', via: :get
  get 'api/transactions/page/:page', to: 'api/transactions#page', via: :get
  post 'api/transactions/new', to: 'api/transactions#create', via: :post
  post 'api/transactions/:id', to: 'api/transactions#update', via: :post
  get 'api/transactions/:id', to: 'api/transactions#show', via: :get
  delete 'api/transactions/:id', to: 'api/transactions#destroy', via: :post
end
