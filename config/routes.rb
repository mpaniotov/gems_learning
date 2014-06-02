Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :tests, only: :index
  resources :pjax, only: :index
  resources :braintrees, only: :index

  get 'albums' => 'tests#getjson',:defaults => { :format => 'json' }

  get 'page1' => 'pjax#page1'
  get 'page2' => 'pjax#page2'
  get 'page3' => 'pjax#page3'

  get 'customer_create' => 'braintrees#customer_create'


  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  root :to => 'tests#index'

end
