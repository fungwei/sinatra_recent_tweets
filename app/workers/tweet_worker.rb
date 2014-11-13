class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = PendingTweet.find(tweet_id)
    user = tweet.user

    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here

    twitter_client = User.twitter_client(user.oauth_token, user.oauth_token_secret)
    twitter_client.update(tweet.body)
  end
end