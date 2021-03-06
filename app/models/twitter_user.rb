class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def self.find_by_username(username)
    if TwitterUser.exists?(username: username)
      user = TwitterUser.find_by(username: username)
    else
    user = TwitterUser.new(username: username)
      if user.save
        user
      end
    end
  end

  def fetch_tweets!(twitter_client)
    self.tweets.destroy_all
    twitter_client.user_timeline(self.username, count: 10).each do |pulled_tweet|
      self.tweets.create(body: pulled_tweet.text)
    end
  end

  def tweets_stale?
    latest_update = self.tweets.first.updated_at
    time_diff = Time.now - latest_update
    time_diff > 60
  end

  def new_tweet(body,twitter_client)
    twitter_client.update(body)
  end

end
