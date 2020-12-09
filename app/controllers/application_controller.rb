require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV["SESSION_SECRET"]
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome, :layout => false
    end
  end

  helpers do 

    # checks if user is logged in
    def logged_in?
      !!session[:user_id]
    end

    # keeps track of which user is currently logged in
    def current_user
      User.find_by(id: session[:user_id])
    end

  end

end
