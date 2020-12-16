class YarnsController < ApplicationController

  before '/yarns' do
    redirect_if_not_logged_in
  end

  before '/yarns/*' do
    redirect_if_not_logged_in
    find_by_yarn(params["splat"][0])
    if @project != nil
      authorized?(@yarn.user)
    end
  end

  get "/yarns" do
    erb :"/yarns/index"
  end

  get "/yarns/new" do
    erb :"/yarns/new"
  end

  post "/yarns" do
    yarn = current_user.yarns.new(params[:yarn])
    if yarn.save
      flash[:message] = "You have successfully added your hank of yarn!"
      redirect "/yarns/#{yarn.id}"
    else
      flash[:message] = "Brand, Name, Weight, Color, and Quantity are required."
      redirect "yarns/new"
    end
  end

  get "/yarns/:id" do
    erb :"/yarns/show"
  end

  get "/yarns/:id/edit" do
    erb :"/yarns/edit"
  end

  patch "/yarns/:id" do
    @yarn.update(params[:yarn])
    if @yarn.save
      redirect "/yarns/#{@yarn.id}"
    else
      redirect "/users/#{user.id}"
    end
  end

  delete "/yarns/:id" do
    @yarn.destroy
    flash[:message] = "#{@yarn.brand}: #{@yarn.name} has been deleted successfully!"
    redirect "/yarns"
  end

end
