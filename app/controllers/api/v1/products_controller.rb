class Api::V1::ProductsController < Api::V1::BaseController

    before_action :verify_auth_token, except: [:create]
    before_action :set_product, only: [:show, :update]

  
    def create
      @product = Product.new(product_params)
      if @product.save
        json_response('success', "1", Api::V1::ProductSerializer.new(@product).serializable_hash[:data][:attributes])
      else
        render_json({message: ErrorDecorator.new(@user).display_errors, rstatus: 0}.to_json)
      end
    end

  
    private

    def set_product
      @product = Product.find_by_id(params[:id])
    end

    def product_params
      params.permit(:name, :description, :price)
    end
  
  
  end
  
  