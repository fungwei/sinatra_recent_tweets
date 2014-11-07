get '/:username' do
  # @user = TwitterUser.find_by_username(params[:username])
  # if (@user.tweets.empty? || @user.tweets_stale?)
  #   # User#fetch_tweets! should make an API call
  #   # and populate the tweets table
  #   #
  #   # Future requests should read from the tweets table
  #   # instead of making an API call
  #   @user.fetch_tweets!
  # end

  # @tweets = @user.tweets
  erb :'tweets/new'
end

get '/:username/refresh' do
  @user = TwitterUser.find_by_username(params[:username])
  if (@user.tweets.empty? || @user.tweets_stale?)
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    # Future requests should read from the tweets table
    # instead of making an API call
    @user.fetch_tweets!
  end

  @tweets = @user.tweets
  erb :'tweets/show', :layout => false
end

post '/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  @user.new_tweet(params[:tweet])
  @user.fetch_tweets!
  @tweets = @user.tweets
  erb :'tweets/show', :layout => false
end