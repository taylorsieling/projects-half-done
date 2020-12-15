class ProjectsController < ApplicationController

  get "/projects" do
    redirect_if_not_logged_in
    @user = current_user
    @projects = current_user.projects
    erb :"/projects/index"
  end

  get "/projects/new" do
    redirect_if_not_logged_in
    erb :"/projects/new"
  end

  post "/projects" do
    current_user.Project.new(params[:project])
    if project.save
      flash[:message] = "You have successfully created a new project!"
      redirect "/projects/#{project.id}"
    else
      flash[:message] = "Name, Category, and Knit Time are required."
      redirect "projects/new"
    end
  end

  get "/projects/:id" do
    redirect_if_not_logged_in
    find_by_project
    erb :"projects/show"
  end

  get "/projects/:id/edit" do
    redirect_if_not_logged_in
    find_by_project
    authorized?(@project.user)
    erb :"/projects/edit"
  end

  patch "/projects/:id" do
    user = current_user
    find_by_project
    @project.update(params[:project])
    if @project.save
      redirect "/projects/#{@project.id}"
    else
      redirect "/users/#{user.id}"
    end
  end

  delete "/projects/:id" do
    find_by_project
    authorized?(@project.user)
    @project.destroy
    flash[:message] = "#{@project.name} has been deleted successfully!"
    redirect "/projects"
  end
  
end