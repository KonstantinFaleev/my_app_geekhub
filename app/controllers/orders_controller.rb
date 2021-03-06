class OrdersController < InheritedResources::Base
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderMailer.received(@order).deliver_later
        format.html { redirect_to store_index_url, notice:
            'Thank you for your order.' }
        format.json { render :show, status: :created,
                             location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors,
                             status: :unprocessable_entity }
      end
    end
  end
  private

    def ensure_cart_isnt_empty
      if @cart.line_items.empty?
        redirect_to store_index_url, notice: 'Your cart is empty'
      end
    end

    def order_params
      params.require(:order).permit(:name, :comment, :phone, :email, :pay_type)
    end
end

