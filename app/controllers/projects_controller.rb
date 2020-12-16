class ProjectsController < ApplicationController

  before '/projects' do
    redirect_if_not_logged_in
  end

  before '/projects/*' do
    redirect_if_not_logged_in
    find_by_project(params["splat"][0])
    authorized?(@project.user)
  end

  get "/projects" do
    erb :"/projects/index"
  end

  get "/projects/new" do
    erb :"/projects/new"
  end

  post "/projects" do
    project = current_user.projects.new(params[:project])
    if project.save
      flash[:message] = "You have successfully created a new project!"
      redirect "/projects/#{project.id}"
    else
      flash[:message] = "Name, Category, and Knit Time are required."
      redirect "projects/new"
    end
  end

  get "/projects/:id" do
    erb :"projects/show"
  end

  get "/projects/:id/edit" do
    erb :"/projects/edit"
  end

  patch "/projects/:id" do
    @project.update(params[:project])
    if @project.save
      redirect "/projects/#{@project.id}"
    else
      redirect "/users/#{current_user.id}"
    end
  end

  delete "/projects/:id" do
    @project.destroy
    flash[:message] = "#{@project.name} has been deleted successfully!"
    redirect "/projects"
  end
  
end