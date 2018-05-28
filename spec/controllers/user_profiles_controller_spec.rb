require 'rails_helper'

RSpec.describe UserProfilesController, type: :controller do
  
  describe 'GET #new' do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
    
    it "returns http success" do
      @user_profile = build(:user_profile)
      allow(UserProfile).to receive(:new).and_return(@user_profile)
      get :new
      expect(response).to render_template :new
    end 
  end
  
  describe "#create" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
    
    context "for valid resource" do
      before(:each) do
        @profile = create(:user_profile)
        post :create, :params => { user_profile: attributes_for(:user_profile) }
      end
      
      it "redirects to the transaction page" do        
        response.should redirect_to deposite_accounts_index_url
      end
      
      # it "permission to download transaction if user is manager" do
        # if @profile.account_type == 1
          # redirect_to deposite_accounts_index_url
          # should have_link('Export Transactons', href: deposite_accounts_export_transaction_path)
        # end
      # end
    end
      
    context "with invalid attributes" do
      it "does not save the new contact" do
        expect{
          post :create, :params => { user_profile: attributes_for(:user_profile).merge(name: nil) }
        }.to_not change(UserProfile,:count)
      end
      
      it "re-renders the new method" do
        post :create, :params => { user_profile: attributes_for(:user_profile).merge(name: nil) }
        response.should redirect_to deposite_accounts_index_path
      end
    end 
  end
  
end
