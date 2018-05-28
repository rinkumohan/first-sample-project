Rails.application.routes.draw do
  
  root :to => "deposite_accounts#index"
  
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :user_profiles
  
  namespace :deposite_accounts do
      get 'index'
      get 'new_transaction'
      post 'update_credit'
      post 'update_debit'
      get 'balance_enquiry'
      get 'transaction_history'
      get 'export_transaction'
  end
   
end
