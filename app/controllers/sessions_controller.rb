class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email] )
      logger.debug "User: #{user.inspect}"
      logger.debug user.authenticate("1111") == false
      #logger.debug "User Password Digest: #{user.password_digest}"
      if user && user.authenticate(params[:password])
        
        payload = {user_id: user.id}
        secret_key = Rails.application.credentials.secret_key_base
        token = JWT.encode(payload, secret_key)
        logger.debug token
        render json: {  token: token, status: "Welcome, #{user.name}" }, status: :ok
      else
        render json: { errors: 'email or password is wrong' }, status: :unauthorized
      end
    end
  end
