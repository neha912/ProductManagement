class Api::V1::UsersController < Api::V1::BaseController

    before_action :verify_auth_token, except: [:create]
  
    def index
      @users = User.order(:created_at).page(params[:page])
      if @users.present?
        json_response("success", "1", Api::V1::UserDetailsSerializer.new(@users, params: {request: request}).serializable_hash[:data].map {|item| item[:attributes]})
      else
        render_json({message: ErrorDecorator.new(@users).display_errors, rstatus: 0}.to_json)
      end
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        auth_token = @user.generate_authentication_token(params[:device_type], params[:device_token])
        json_response("success", "1", Api::V1::AuthenticationTokenSerializer.new(auth_token, params: {request: request}).serializable_hash[:data][:attributes])
      else
        render_json({message: ErrorDecorator.new(@user).display_errors, rstatus: 0}.to_json)
      end
    end
  
    def show
      if @current_user.present?
        json_response("success", "1", Api::V1::AuthenticationTokenSerializer.new(@auth_token, params: {request: request}).serializable_hash[:data][:attributes])
      else
        render_json({message: 'failure', rstatus: 0, data: {}}.to_json)
      end
    end
  
    def update
      if @current_user.update_attributes(user_params)
        json_response("success", "1", Api::V1::AuthenticationTokenSerializer.new(@auth_token, params: {request: request}).serializable_hash[:data][:attributes])
      else
        render_json({message: ErrorDecorator.new(@current_user).display_errors, rstatus: 0}.to_json)
      end
    end
  
    private
  
    def user_params
      params
      .permit(:first_name,
              :last_name,
              :email,
              :password,
              :password_confirmation)
    end
  
  end
  
  
  
  
  