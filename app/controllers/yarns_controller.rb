class YarnsController < ApplicationController

  get "/yarns" do
    redirect_if_not_logged_in
    @user = current_user
    erb :"/yarns/index"
  end

  get "/yarns/new" do
    redirect_if_not_logged_in
    @projects = current_user.projects
    erb :"/yarns/new"
  end

  post "/yarns" do
    @yarn = Yarn.new(params[:yarn])
    if @yarn.save
      current_user.yarns << @yarn
      flash[:message] = "You have successfully added your hank of yarn!"
      redirect "/yarns/#{@yarn.id}"
    else
      flash[:message] = "Brand, Name, Weight, Color, and Quantity are required."
      redirect "yarns/new"
    end
  end

  get "/yarns/:id" do
    redirect_if_not_logged_in
    @yarn = Yarn.find_by_id(params[:id])

    if @yarn.user != current_user
      flash[:alert] = "You are not authorized to view that yarn. Please choose one of the hanks below."
      redirect "/yarns"
    else
      erb :"/yarns/show"
    end
  end

  get "/yarns/:id/edit" do
    redirect_if_not_logged_in
    @projects = current_user.projects
    @yarn = Yarn.find_by_id(params[:id])
    if @yarn.user != current_user
      flash[:alert] = "You are not authorized to edit that yarn. Please choose one of the hanks below."
      redirect "/yarns"
    else
      erb :"/yarns/edit"
    end
  end

  patch "/yarns/:id" do
    @yarn = Yarn.find_by_id(params[:id])
    @yarn.update(params[:yarn])
    if @yarn.save
      redirect "/yarns/#{@yarn.id}"
    else
      redirect "/users/#{user.id}"
    end
  end

  delete "/yarns/:id" do
    @yarn = Yarn.find_by_id(params[:id])
    if @yarn.user != current_user
      redirect to '/'
    else 
    flash[:message] = "#{@yarn.brand}: #{@yarn.name} has been deleted successfully!"
    @yarn.destroy
    redirect "/yarns"
    end
  end

end
