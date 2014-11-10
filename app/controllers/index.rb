use Rack::Flash

get '/' do
  if session[:user_id] == nil
    erb :index
  elsif User.find(session[:user_id]).twitter_username == nil
    redirect '/oauth/request_token'
  else
    user = User.find(session[:user_id])
    redirect "/tweets/#{user.twitter_username}"
  end
end

post '/go_to_user' do
   redirect "/tweets/#{params[:tweetUser]}"
end