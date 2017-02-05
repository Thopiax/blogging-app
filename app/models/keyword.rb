class Keyword < ApplicationRecord
  belongs_to :post
  validates :name, presence: true
  validates :image_url, presence: true
end
