# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  protected
  
  # The path used after sign in.
  def after_sign_in_path_for(resource)
    sign_in_path = !current_user.user_profile.blank? ? "#{root_path}" : "#{new_user_profile_path}"
  end
  
end
