class LineItem < ActiveRecord::Base
  # default_scope { order('updated_at DESC') }
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end
end