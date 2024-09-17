class TransactionsController < ApplicationController
    before_action :set_account
    before_action :set_transaction, only: [:show, :update, :destroy]
    before_action :authenticate
  
    def index
      @transactions = @account.transactions.order(date: :asc)
      render json: @transactions
    end
  
    def show
      render json: @transaction
    end
  
    def create
      @transaction = @account.transactions.new(transaction_params)
  
      if @transaction.save
        render json: @transaction, status: :created
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @transaction.update(transaction_params)
        render json: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @transaction.destroy
      
    end
  
    private
  
    def set_account
      @account = Account.find(params[:account_id])
    end
  
    def set_transaction
      @transaction = @account.transactions.find(params[:id])
    end
  
    def transaction_params
      params.require(:transaction).permit(:date, :income, :expense, :description)
    end
  end
  