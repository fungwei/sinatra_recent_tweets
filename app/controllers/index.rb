get '/' do
end

get '/:username' do
    @user = TwitterUser.find_by_username(params[:username])
  if @user.tweets.empty?
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    # Future requests should read from the tweets table
    # instead of making an API call
    @user.fetch_tweets!
  end

  @tweets = @user.tweets
  erb :index
end