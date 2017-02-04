# Model for the posts in the blogging service
class Post < ActiveRecord::Base
  validates :message, presence: true, length: { maximum: 9999999 }
end
