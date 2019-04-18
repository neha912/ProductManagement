class ErrorDecorator < SimpleDelegator
    # delegate_all
  
    def display_errors
        errors.full_messages.join(', ')
    end
  end
  
  
  