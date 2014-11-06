class TwitterUser
  def initialize(username)
    @username = username
    @tweets = []
  end

  def self.find_by_username(username)
    user = TwitterUser.new(username)
  end



  def fetch_tweets!
    TWITTER_CLIENT.user_timeline(@username, count: 10).each do |tweet|
      temp_tweet = Tweet.new(tweet.text)
      @tweets << temp_tweet
    end
  end

  def tweets
    @tweets
  end
end