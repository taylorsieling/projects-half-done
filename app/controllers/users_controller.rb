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
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else redirect "/login"
    end
    erb :"user"
  end

  # getting error with attempting to interpolate in erb
  # research later
  get "/users/:id" do
    @user = User.find_by(id: params[:id])
    erb :"/users/show"
  end

  # # GET: /users/5/edit
  # get "/users/:id/edit" do
  #   erb :"/users/edit"
  # end

  # # PATCH: /users/5
  # patch "/users/:id" do
  #   redirect "/users/:id"
  # end

  # # DELETE: /users/5/delete
  # delete "/users/:id/delete" do
  #   redirect "/users"
  # end

end
