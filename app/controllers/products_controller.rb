class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all   
  end

  def show; end
  
  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product was created successfully"
      redirect_to @product
    else
      render :new 
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product
      flash[:success] = "Product was successfully updated"
    else
      render :edit
    end
  end


  def destroy
    @product.destroy
    flash[:notice] ='Product was successfully destroyed.' 
    redirect_to products_path
  end


  def import
    Product.import(params[:file])
    redirect_to products_path, notice: "Product Uploaded successfully"
   end

  private

    def set_product
      @product = Product.find_by_id(params[:id])
      redirect_to products_path if @product.blank?
    end

    def product_params
      params.require(
        :product
      ).permit(
        :name,
        :description,
        :price
      )
    end
end
