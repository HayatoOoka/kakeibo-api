class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  #before_action :authorize_request, except: :create
  before_action :authenticate, expect: :create

  def index
    @users = User.all
    render json: @users
  end

  def transactions
    user = User.find(params[:id])
    accounts = user.accounts
    transactions = Transaction.where(account_id: accounts.pluck(:id))

    render json: transactions
  end
    
  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    #@user.password_digest = BCrypt::Password.create(params[:password]) #秘密鍵をつくる   
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :bad_request
    end
                      end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :organization_id,:email,:password)
  end
end

