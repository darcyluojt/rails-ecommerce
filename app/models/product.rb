class Product < ApplicationRecord
  has_one_attached :image
  after_commit -> { broadcase_refresh_later_to "products" }
end
