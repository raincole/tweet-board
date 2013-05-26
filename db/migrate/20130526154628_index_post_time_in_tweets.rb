class IndexPostTimeInTweets < ActiveRecord::Migration
  def change
    add_index :tweets, :post_time
  end
end
