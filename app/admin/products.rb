ActiveAdmin.register Product do
    permit_params :title, :description, :price, images: []

    index do
      selectable_column
      id_column

      column :title
      column :price
      column :description
      column :images do |product|
        div class: 'image-list' do
          product.images.each do |image|
            div class: 'image' do
              image_tag(image.url(:mini))
            end
          end
        end
      end
      actions
    end

    show do
      attributes_table do
        row :title
        row :description
        row :price
        row :images do
          div do
            product.images.each do |image|
              div do
                image_tag(image.url(:thumb))
              end
            end
          end
        end
      end
    end

    form html: { multipart: true } do |f|
      f.semantic_errors

      f.inputs do
        f.input :title
        f.input :description
        f.input :price
        f.input :images, as: :file, input_html: { multiple: true }
      end

      actions
    end
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
