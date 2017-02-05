class AddDetailsToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :sentiment, :string
    add_column :posts, :emojis, :string
  end
end
