class DepositeAccountsController < ApplicationController
  layout 'application_layout'
  
  before_action :authenticate_user!
  before_action :get_user_profile, only: [:index, :balance_enquiry, :transaction_history]
  before_action :get_current_balance, only: [:update_credit, :update_debit]
  
  def index 
  end
  
  #Gets the new transaction for the user who are depositing money
  def new_transaction
    @new_transaction = DepositeAccount.new
  end
  
  #Credits the money to the account
  def update_credit
    total_available_balance = @current_balance + params[:deposite_account][:last_transaction_amount].to_i
    update_deposite_account(total_available_balance)
    redirect_to deposite_accounts_index_path
  end
  
  #Debits the money from the account
  def update_debit
    if @current_balance != 0 || @current_balance > params[:deposite_account][:last_transaction_amount].to_i
      total_available_balance = @current_balance - params[:deposite_account][:last_transaction_amount].to_i
      update_deposite_account(total_available_balance)
    else
      flash[:error] = "You are currently out of money for this transaction"
    end
    redirect_to deposite_accounts_index_path
  end
  
  #Returns the available balance
  def balance_enquiry
    @account = DepositeAccount.get_current_user_account(current_user).first
  end
  
  #Displays the transaction history
  def transaction_history
    @all_transactions = DepositeAccount.get_current_user_account(current_user)
  end
  
  def export_transaction
    @users = User.includes(:user_profile).all
    @months = (1..12).to_a.collect {|m| Date::MONTHNAMES[m]}
    @year = ((Date.today.year-2)..(Date.today.year+2)).to_a
    @selected_from_month = params[:from_month].blank? ? @months.first : params[:from_month]
    @selected_to_month = params[:to_month].blank? ? @months.last : params[:to_month]
    @selected_from_year = params[:from_year].blank? ? Date.today.year : params[:from_month]
    @selected_to_year = params[:to_year].blank? ? Date.today.year : params[:to_month]
    @selected_user = params[:user_id].blank? ? @users.pluck(:id) : [params[:user_id]]
    
    @transactions = DepositeAccount.find_all_transactions(@selected_user,@selected_from_year,@selected_from_month,@selected_to_year,@selected_to_month)
  end
  
  private
  
  def deposite_params
    params.require(:deposite_account).permit(:transaction_type, :last_transaction_amount, :available_balance, :user_id)
  end
  
  #Returns the user's profile
  def get_user_profile
    @user_profile = current_user.user_profile
  end
  
  #Returns the current_balance
  def get_current_balance
    account = DepositeAccount.get_current_user_account(current_user)
    @current_balance = account.blank? ? 0 : account.first.available_balance
  end
  
  #Creates new transactions
  def update_deposite_account total_available_balance
    @new_transaction = DepositeAccount.new(deposite_params.merge(user_id: current_user.id, available_balance: total_available_balance))
    flash[:notice] = "Successful Transaction" if @new_transaction.save
    flash[:error] = @new_transaction.errors.full_messages.uniq.join(', ') if !@new_transaction.save
  end
  
end
