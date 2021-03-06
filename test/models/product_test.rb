require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products

  test "product is not valid with not allowed length of title" do
    product = Product.new(title:       '我超愛吃漢堡',
                          description: '我超愛吃漢堡',
                          price:       1,
                          image_url:   'humburger.jpg')
    assert product.invalid?
  end

  test "product is not valid without a unique title" do
    product = Product.new(title:       products(:ruby).title,
                          description: products(:ruby).description,
                          price:       1,
                          image_url:   products(:ruby).image_url)
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  def new_product(image_url)
    Product.new(title:       "My book title",
                description: "My book description",
                price:       1,
                image_url: image_url)
  end

  test "products attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = new_product('abc.png')
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{red.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end
end
