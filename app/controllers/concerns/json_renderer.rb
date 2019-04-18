module JsonRenderer

    def json_response(message, status, data)
      render json: { message: message, rstatus: status, data: data }
    end
  
    def render_json(json)
      callback = params[:callback]
      response = begin
        if callback
          "#{callback}(#{json});"
        else
          json
        end
      end
    render({:content_type => 'application/javascript', :plain => response})
    end
  
  end
  