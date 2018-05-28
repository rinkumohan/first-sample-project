class UserProfilesController < ApplicationController
  
  layout 'application_layout'
  
  before_action :authenticate_user!
  before_action :find_user_profile, only: [:edit, :update]
  
  def new
    @user_profile = UserProfile.new
  end
  
  def create
    @user_profile = UserProfile.new(profile_params.merge(user_id: current_user.id))
    flash[:success] = "Successfully Updated the Profile" if @user_profile.save
    flash[:error] = @user_profile.errors.full_messages.uniq.join(', ') if !@user_profile.save
    redirect_to deposite_accounts_index_path
  end
  
  def edit
  end
  
  def update
    user_profile = @user_profile.update_attributes(profile_params)
    flash[:success] = "Successfully Updated the Profile" if user_profile
    flash[:error] = @user_profile.errors.full_messages.uniq.join(', ') if !user_profile
    redirect_to deposite_accounts_index_path
  end
  
  private
  
  def profile_params
    params.require(:user_profile).permit(:name, :sex, :address, :phone_number, :profile_photo, :account_type, :account_number, :user_id)  
  end
  
  def find_user_profile
    @user_profile = current_user.user_profile
  end
  
end
