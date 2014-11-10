get '/tweets/:username' do
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
  @post_valid = User.find(session[:user_id]).twitter_username == params[:username]
  erb :'tweets/new'
end

get '/tweets/:username/refresh' do
  @user = TwitterUser.find_by_username(params[:username])
  if (@user.tweets.empty? || @user.tweets_stale?)
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    # Future requests should read from the tweets table
    # instead of making an API call
    logged_in_user = User.find(session[:user_id])
    twitter_client = User.twitter_client(logged_in_user.oauth_token, logged_in_user.oauth_token_secret)
    @user.fetch_tweets!(twitter_client)
  end

  @tweets = @user.tweets
  erb :'tweets/show', :layout => false
end

post '/tweets/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  logged_in_user = User.find(session[:user_id])
  twitter_client = User.twitter_client(logged_in_user.oauth_token, logged_in_user.oauth_token_secret)
  @user.new_tweet(params[:tweet], twitter_client)
  @user.fetch_tweets!(twitter_client)
  @tweets = @user.tweets
  erb :'tweets/show', :layout => false
end