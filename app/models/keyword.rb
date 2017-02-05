class Keyword < ApplicationRecord
  belongs_to :post
  validates :image_url, presence: true
end
