class AccountsController < ApplicationController
    before_action :set_account, only: %i[show update destroy]
    before_action :authenticate
  
    # GET /accounts
    def index
      @accounts = Account.where(user_id: @current_user.id)#.where~にかえる
      render json: @accounts
    end
  
    # GET /accounts/:id
    def show
      render json: @account
    end
  
    # POST /accounts
    def create
      @account = Account.new(account_params)
      @account.user_id = @current_user.id
      if @account.save
        render json: @account, status: :created
      else
        logger.debug @account.errors.full_messages
        render json: @account.errors, status: :bad_request
      end
    end
  
    # PUT /accounts/:id
    def update
      if @account.update(account_params)
        render json: @account
      else
        render json: @account.errors, status: :bad_request
      end
    end
  
    # DELETE /accounts/:id
    def destroy
      @account.destroy
    end
  
    private
  
    # アカウントを見つけるためのメソッド
    def set_account
      @account = Account.find(params[:id])
    end
  
    # Strong Parameters: アカウントの登録や更新に必要なパラメータを制限
    def account_params
      params.require(:account).permit(:name)
    end
  end
  