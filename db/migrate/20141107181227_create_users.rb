class CreateUsers < ActiveRecord::Migration
  def change
    create_table  :users do |t|
      t.string    :username, null: false
      t.string    :password, null: false
      t.string    :oauth_token
      t.string    :oauth_token_secret
      t.string    :twitter_username

      t.timestamps
    end
  end
end
