# Model for the posts in the blogging service
class Post < ActiveRecord::Base
  validates :message, presence: true, length: { maximum: 9999999 }
  validates :sentiment, presence: true
  validates :sent_emoji, presence: true
  validate  :emojis
  has_many :keywords
end
