get '/login' do
  erb :'users/new'
end

delete '/logout' do
  session[:user_id] = nil
  redirect "/"
end

post '/users' do
  if params[:submit] == "create"
    @user = User.new(username: params[:username], password: params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect "/oauth/request_token"

  else
    # byebug
    if User.valid?(params[:username])
    user = User.where(username: params[:username]).first
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        if user.twitter_username == nil
          redirect "/oauth/request_token"
        else
          redirect "/tweets/#{user.twitter_username}"
        end
      else
        flash[:notice] = "Wrong Password"
        erb :'users/new'
      end
    else
      flash[:notice] = "No such user exists"
      erb :'users/new'
    end
  end

end

