class UserProfile < ApplicationRecord
  has_one :user, dependent: :destroy
  
  mount_uploader :profile_photo, AvatarUploader
  validates :name, :address, :phone_number, :account_type, :account_number, presence: true
  
  ACCOUNTTYPE = [["Manager",1],["User",2]]
end
