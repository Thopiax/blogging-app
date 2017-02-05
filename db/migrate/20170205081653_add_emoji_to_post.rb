class AddEmojiToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :sent_emoji, :string
  end
end
