class TransactionUpdateMailer < ApplicationMailer
  default from: "no-reply@testbanking.com"
  
  def send_transaction_alert_mail transaction_id
    @transaction = DepositeAccount.find_by_id(transaction_id)
    @user = User.find_by_id(@transaction.user_id)
    @user_profile = user.user_profile
    mail(to: @user.email, subject: "Banking Site: Transaction Notification")
  end

end
