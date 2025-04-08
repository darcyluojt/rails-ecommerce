require "test_helper"
require "faker"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  test "product price must be positive" do
    product = Product.new(title: Faker::Book.title,
                          description: Faker::Lorem.paragraph,
                          price: -1)
    product.image.attach(io: File.open("db/images/Manga.png"),
                         filename: "Manga.png",
                         content_type: "image/png")
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]
    product.price = 1
    assert product.valid?
  end
end
