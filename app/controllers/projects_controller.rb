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
    project = Project.new(params[:project])
    if project.save
      current_user.projects << project
      flash[:message] = "You have successfully created a new project!"
      redirect "/projects/#{project.id}"
    else
      flash[:message] = "Name, Category, and Knit Time are required."
      redirect "projects/new"
    end
  end

  get "/projects/:id" do
    redirect_if_not_logged_in
    @project = Project.find_by_id(params[:id])
    if @project.user != current_user
      flash[:alert] = "You are not authorized to view that project. Please choose one of the projects below."
      redirect "/projects"
    else
      erb :"/projects/show"
    end
  end

  get "/projects/:id/edit" do
    redirect_if_not_logged_in
    @project = Project.find_by_id(params[:id])
    if @project.user != current_user
      flash[:alert] = "You are not authorized to edit that project. Please choose one of the projects below."
      redirect "/projects"
    else
      erb :"/projects/edit"
    end
  end

  patch "/projects/:id" do
    user = current_user
    @project = Project.find_by_id(params[:id])
    @project.update(params[:project])
    if @project.save
      redirect "/projects/#{@project.id}"
    else
      redirect "/users/#{user.id}"
    end
  end

  delete "/projects/:id" do
    @project = Project.find_by_id(params[:id])
    if @project.user != current_user
      redirect to '/'
    else 
      flash[:message] = "#{@project.name} has been deleted successfully!"
      @project.destroy
      redirect "/projects"
    end
  end
  
end