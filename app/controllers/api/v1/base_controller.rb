class Api::V1::BaseController < ActionController::Base
    protect_from_forgery with: :null_session
  
    before_action :_authenticate_request
    
    include ExceptionHandler
    include JsonRenderer
    
    private
  
    def _authenticate_request
      return true if _token_verified?(request.headers['Authorization'])
      render_json jsonapi_errors: {}, status: 401
    end
  
    def _token_verified?(headers)
      auth_type, submitted_token = request.headers['Authorization'].presence&.split
      verification_token = 'm5wPgRVoyrZ51MGtPxZtGuq7Xz8YGV4AQNBpeLkj'
      auth_type == 'Bearer' &&
      submitted_token &&
      ActiveSupport::SecurityUtils.secure_compare(submitted_token, verification_token)
    end
  
    def verify_auth_token
      @auth_token = AuthenticationToken.find_by(auth_token: request.headers['HTTP_AUTH_TOKEN'])
      unless @auth_token.present?
        render_json({message: "Please login to processed further.", rstatus: 0}.to_json)
      else
        @current_user = @auth_token.user
      end
    end
  

  end
  
  