class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
      @products = Product.all
  end

  def search
    @products = Product.where("name LIKE ?", "%#{params[:search]}%")
    @search = params[:search]
    render :index
  end

  # GET /products/1
  # GET /products/1.json
  def show
    #@product = Product.find_by_id(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    #@product = Product.find_by_id(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = 'Producto creado exitosamente'
      redirect_to '/products'
    else
      render action: "new"
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product = Product.find(params[:id])
      if @product.update(product_params)
        flash[:success] = "Producto actualizado exitosamente"
        redirect_to '/products'
      else
        render action: "edit"
      end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:code, :name, :description, :state)
    end
end
