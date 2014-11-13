class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :pending_tweets

  validates :username, uniqueness: true, presence: true
  validates :password, presence: true

  def self.valid?(username)
    User.exists?(username: username)
  end

  def authenticate(attempted_password)
    self.password == attempted_password
  end

  def self.twitter_client(oauth_token, oauth_token_secret)
      twitter_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = CONSUMER_KEY
        config.consumer_secret     = CONSUMER_SECRET
        config.access_token        = oauth_token
        config.access_token_secret = oauth_token_secret
      end

      twitter_client
  end

    def tweet(status)
      tweet = self.pending_tweets.create!(body: status)
      TweetWorker.perform_async(tweet.id)
    end

end
