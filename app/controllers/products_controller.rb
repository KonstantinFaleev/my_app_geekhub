class ProductsController < InheritedResources::Base

  private

    def product_params
      params.require(:product).permit(:title, :description, :image, :price)
    end
end

