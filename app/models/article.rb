class Article < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :images
end
