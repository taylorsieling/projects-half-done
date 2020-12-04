class UsersController < ApplicationController

  get "/signup" do
    erb :"/users/new"
  end

  post "/signup" do
    @user = User.create(params[:user])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end

  get "/login" do
    erb :"/users/login"
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
    erb :"user"
  end

  get "/logout" do
    session.clear
    redirect '/'
  end

  get "/users/:id" do
    @user = User.find_by(id: params[:id])
    erb :"/users/show"
  end

  get "/users/:id/edit" do
    @user = User.find_by(id: params[:id])
    erb :"/users/edit"
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

  delete "/users/:id/delete" do
    redirect "/"
  end

end
