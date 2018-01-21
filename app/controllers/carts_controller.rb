class CartsController < InheritedResources::Base
  #before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def index
    @carts = Cart.all
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to store_index_url }
      format.json { head :no_content }
    end
  end

  private

    def cart_params
      params.require(:cart).permit()
    end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to store_index_url, notice: 'Invalid cart'
    end
end

