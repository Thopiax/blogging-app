# Model for the posts in the blogging service
class Post < ActiveRecord::Base
  validates :message, presence: true, length: { maximum: 9999999 }
  validates :sentiment
  validates :emojis
  validates :sent_emoji
  has_many :keywords

  # after_initialize :init
  #
  # def init
  #   self.sentiment         ||= '#ffffff'           #will set the default value only if it's nil
  #   self.emojis            ||= '' #let's you set a default association
  #   self.sent_emoji        ||= ''
  # end
end
