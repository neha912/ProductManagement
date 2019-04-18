class Api::V1::SessionsController < Api::V1::BaseController
    protect_from_forgery with: :null_session
    before_action :verify_auth_token, only: [:destroy]
  
    def create
      @user = User.find_by(email: params[:email])
      if @user && @user.valid_password?(params[:password])
        auth_token = @user.generate_authentication_token(params[:device_type], params[:device_token])
        json_response('success', "1", Api::V1::AuthenticationTokenSerializer.new(auth_token, params: {request: request}).serializable_hash[:data][:attributes])
      else
        render_json({message: 'input_failure', rstatus: 0, data: {}}.to_json)
      end
    end
  
    def destroy
      if @current_user.present? && @auth_token.destroy
        render_json({message: 'success', rstatus: 1, data: {}}.to_json)
      else
        render_json({message: 'failure', rstatus: 0, data: {}}.to_json)
      end
    end
  
  end
  
  