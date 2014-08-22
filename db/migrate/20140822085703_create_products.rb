class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url

      # definition of the price to have a eight digits or significance and two digits after the decimal point.
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
