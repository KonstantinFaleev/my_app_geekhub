class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.text :comment
      t.string :email
      t.integer :status, default: 0
      t.integer :pay_type

      t.timestamps
    end
  end
end
