class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |table|
        table.text :message
        table.timestamps null: false
    end
  end
end
