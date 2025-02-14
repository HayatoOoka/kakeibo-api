module JwtToken
    extend ActiveSupport::Concern
  
    # JWTをデコードする（発行したトークンの中身を確認）
    class_methods do
      def decode(token)
        JWT.decode token, Rails.application.secret_key_base
      end
    end
  
    def create_tokens
      payload = { user_id: id }
      issue_token(payload.merge(exp: Time.current.to_i + 1.month))
    end
  
    private
  
    # JWTを発行する
    def issue_token(payload)
      JWT.encode payload, Rails.application.secret_key_base
    end
  end