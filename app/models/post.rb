# Model for the posts in the blogging service
class Post < ActiveRecord::Base
  validates :message, presence: true, length: { maximum: 9999999 }
  attr_accessor :sentiment_colour
  attr_accessor :emojis
  has_many :keywords

  after_initialize :init

  def init
    self.sentiment_colour  ||= '#ffffff'           #will set the default value only if it's nil
    self.emojis            ||= '' #let's you set a default association
  end
end
