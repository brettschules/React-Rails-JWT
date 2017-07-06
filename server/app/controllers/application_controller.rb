class ApplicationController < ActionController::API
  private

  def issue_token payload
  end

  def authorize_user!
    if !current_user.present?
      render json: {error: 'No user id present'}
    end
  end

  def current_user
    @current_user ||= User.find_by(id: token_user_id)
  end

  def token_user_id
    decoded_token.first['user_id']
  end

  def decoded_token
    if token
      begin
      rescue JWT::DecodeError
        return [{}]
      end
    else
      [{}]
    end
  end

  def token
  end

  def secret
    "railsdragons"
  end

  def algorithm
    "HS256"
  end
end
