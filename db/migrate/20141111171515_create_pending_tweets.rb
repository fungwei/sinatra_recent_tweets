class CreatePendingTweets < ActiveRecord::Migration
  def change
    create_table :pending_tweets do |t|
      t.integer :user_id
      t.string :body

      t.timestamps
    end
  end
end
