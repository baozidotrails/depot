class LineItem < ActiveRecord::Base
  # default_scope { order('updated_at DESC') }
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def total_price
    product.price * quantity
  end

  def increase_qty
    increment(:quantity)
  end

  def decrease_qty
    if quantity > 1
      decrement(:quantity)
    else
      destroy
    end
  end
end