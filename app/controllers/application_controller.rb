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

  not_found do 
    flash[:alert] = "Resource not found."
    redirect "/users/#{current_user.id}"
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

    # redirects user that are not logged in
    def redirect_if_not_logged_in
      redirect to "/login" if !logged_in?
      end
    end

    # only shows users authorized pages
    def authorized?(user)
      if user != current_user
        flash[:alert] = "Not Authorized."
        redirect to "/"
      end
    end

    # finds projects by id
    def find_by_project(splat)
      @project = Project.find_by_id(splat)
    end

    #finds yarns by id
    def find_by_yarn(splat)
      @yarn = Yarn.find_by_id(splat)
    end
    
end
