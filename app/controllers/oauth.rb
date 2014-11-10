get '/oauth/request_token' do
  consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, :site => 'https://api.twitter.com'

  request_token = consumer.get_request_token :oauth_callback => CALLBACK_URL
  session[:request_token] = request_token.token
  session[:request_token_secret] = request_token.secret

  puts "request: #{session[:request_token]}, #{session[:request_token_secret]}"

  redirect request_token.authorize_url
end

get '/oauth/callback' do
  consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, :site => 'https://api.twitter.com'

  puts "CALLBACK: request: #{session[:request_token]}, #{session[:request_token_secret]}"

  request_token = OAuth::RequestToken.new consumer, session[:request_token], session[:request_token_secret]
  access_token = request_token.get_access_token :oauth_verifier => params[:oauth_verifier]

  # Twitter.configure do |config|
  #   config.consumer_key = CONSUMER_KEY
  #   config.consumer_secret = CONSUMER_SECRET
  #   config.oauth_token = access_token.token
  #   config.oauth_token_secret = access_token.secret
  # end

  # "[#{Twitter.user.screen_name}] access_token: #{access_token.token}, secret: #{access_token.secret}"

  user = User.find(session[:user_id])

  user.oauth_token = access_token.token
  user.oauth_token_secret = access_token.secret


  twitter_client = User.twitter_client(access_token.token, access_token.secret)

  user.twitter_username = twitter_client.current_user.screen_name

  user.save

  redirect "/tweets/#{user.twitter_username}"

  session[:user_id] = user.id

end