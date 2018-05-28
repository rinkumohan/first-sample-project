class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.string :sex
      t.text :address
      t.string :phone_number
      t.string :profile_photo
      t.integer :account_type
      t.string :account_number
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
