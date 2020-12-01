class UsersController < ApplicationController

  get "/signup" do
    erb :"/users/new"
  end

  post "/signup" do
    @user = User.create(params[:user])
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
    redirect '/signup'
  end

  get "/users/:id" do
    @user = User.find_by(id: params[:id])
    erb :"/users/show"
  end

  get "/users/:id/edit" do
    @user = User.find_by_id(params[:id])
    erb :"/users/edit"
  end

  patch "/users/:id" do
    @user = User.find_by_id(params[:id])
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save
    redirect to "/users/#{@user.id}"
  end

  # # DELETE: /users/5/delete
  # delete "/users/:id/delete" do
  #   redirect "/users"
  # end

end
