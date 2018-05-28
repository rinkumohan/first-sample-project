require 'rails_helper'

RSpec.describe DepositeAccountsController, type: :controller do
  
  describe 'GET #index' do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
    
    it "deposite account load index" do
      user = User.first
      user_profile  = create(:user_profile)
      if user_profile
        get :index
        expect(response).to render_template :index
      else
        expect(response).to redirect_to new_user_profile_path
      end
    end
  end
  
  describe 'GET #new transaction' do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
    
    it "returns http success" do
      @deposite_account = build(:deposite_account)
      allow(DepositeAccount).to receive(:new).and_return(@deposite_account)
      get deposite_accounts_new_transaction_path
      expect(response).to render_template "new_transaction"
    end 
  end
  
  describe "#debit/credit" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
  end
  
end
