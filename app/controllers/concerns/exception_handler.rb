module ExceptionHandler
    extend ActiveSupport::Concern
  
    included do
      rescue_from ActiveRecord::RecordNotFound do |e|
        render_json({message: e.message, rstatus: 0}.to_json)
      end
  
      rescue_from ActiveRecord::RecordInvalid do |e|
        render_json({message: e.message, rstatus: 0}.to_json)
      end
    end
  end
  
  
  