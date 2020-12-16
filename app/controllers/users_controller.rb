class UsersController < ApplicationController

  before '/users/*' do 
    redirect_if_not_logged_in
  end

  get "/signup" do
    if !logged_in?
      erb :"/users/new", :layout => false
    else
      redirect "/users/#{@user.id}"
    end
  end

  post "/signup" do
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      @errors = @user.errors.full_messages
      erb :"users/new", :layout => false
    end
  end

  get "/login" do
    if logged_in?
      redirect "/users/#{@user.id}"
    else
    erb :"/users/login", :layout => false
    end
  end

  post "/login" do
    !params[:user][:username].blank? ? @user = User.find_by_username(params[:user][:username]) : @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else 
      flash[:alert] = "Invalid Login. Please try again."
      redirect "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect '/'
    end
  end

  get "/users/:id" do
    @user = User.find_by(id: params[:id])
    if @user == current_user
      erb :"/users/show"
    else
      flash[:alert] = "Not authorized."
      redirect "/"
    end
  end

  get "/users/:id/edit" do
    @user = User.find_by(id: params[:id])
    if @user == current_user
      erb :"/users/edit"
    else 
      flash[:alert] = "Not authorized."
      redirect "/"
    end
  end

  patch "/users/:id" do
    user = current_user
    user.update(params[:user])
    if user.save
      redirect "/users/#{user.id}"
    else
      redirect '/'
    end
  end

  delete "/users/:id" do
    if user = User.find_by(id: params[:id])
      session.clear
      flash[:message] = "Your account has been deleted successfully!"
      user.destroy
      redirect "/signup"
    else
      flash[:alert] = "Not Authorized."
    end
  end

end
