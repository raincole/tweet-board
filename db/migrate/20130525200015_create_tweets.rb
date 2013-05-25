class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.datetime :post_time, :null => false
      t.string :content, :null => false
      t.string :author_avatar
      t.string :author_name, :null => false
      t.string :author_screen_name
      t.string :twi_id, :null => false
      t.integer :subscription_id

      t.timestamps
    end
  end
end
