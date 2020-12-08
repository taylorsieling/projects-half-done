class YarnsController < ApplicationController

  get "/yarns" do
    @user = current_user
    erb :"/yarns/index"
  end

  get "/yarns/new" do
    @projects = current_user.projects
    erb :"/yarns/new"
  end

  post "/yarns" do
    @yarn = Yarn.create(params[:yarn])
    redirect "/yarns/#{@yarn.id}"
  end

  get "/yarns/:id" do
    @yarn = Yarn.find_by_id(params[:id])
    erb :"/yarns/show"
  end

  get "/yarns/:id/edit" do
    @projects = current_user.projects
    @yarn = Yarn.find_by_id(params[:id])
    erb :"/yarns/edit"
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

  delete "/yarns/:id/delete" do
    yarn = Yarn.find_by_id(params[:id])
    flash[:message] = "#{yarn.brand}: #{yarn.name} has been deleted successfully!"
    project.destroy
    redirect "/yarns"
  end

end
