class Keyword < ApplicationRecord
  belongs_to :post
  has_many :image
end
