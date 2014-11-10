class AddIndexToUsernameInTwitterUsers < ActiveRecord::Migration
  def change
    add_index :twitter_users, :username
  end
end
