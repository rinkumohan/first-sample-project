# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  
  protected

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    sign_up_path = !current_user.user_profile.blank? ? "#{root_path}" : "#{new_user_profile_path}"
  end

end
