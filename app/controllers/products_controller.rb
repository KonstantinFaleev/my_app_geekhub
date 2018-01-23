class ProductsController < InheritedResources::Base

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product,
                                  notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }

        @products = Product.all
        ActionCable.server.broadcast 'products',
                                       html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  private

    def product_params
      params.require(:product).permit(:title, :description, :image, :price)
    end
end

