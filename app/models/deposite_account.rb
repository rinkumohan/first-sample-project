class DepositeAccount < ApplicationRecord
  
  has_one :user, dependent: :destroy
  after_save :send_transaction_mail
  
  default_scope { order(updated_at: :desc) }
  scope :selected_users, -> {  }
  
  #Returns the user deposite account
  def self.get_current_user_account current_user
    return current_user.deposite_accounts
  end
  
  def self.find_all_transactions user_ids, from_year, from_month, to_year, to_month
    from_date = "1-#{from_month}-#{from_year}".to_date
    to_date = "1-#{to_month}-#{to_year}".to_date
    
  end
  
  private
  
  def send_transaction_mail
    TransactionUpdateMailer.send_transaction_alert_mail(self.id)
  end
end
