class ProjectsController < ApplicationController

  get "/projects" do
    @projects = current_user.projects
    erb :"/projects/index"
  end

  get "/projects/new" do
    erb :"/projects/new"
  end

  post "/projects" do
    project = Project.new(params[:project])
    if project.save
      current_user.projects << project
      flash[:notice] = "You have successfully created a new project!"
      redirect "/projects/#{project.id}"
    else
      flash[:message] = "All fields are required."
      redirect "projects/new"
    end
  end

  get "/projects/:id" do
    @project = Project.find_by_id(params[:id])
    erb :"/projects/show"
  end

  # GET: /projects/5/edit
  get "/projects/:id/edit" do
    @project = Project.find_by_id(params[:id])
    erb :"/projects/edit"
  end

  # PATCH: /projects/5
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
    project = Project.find_by_id(params[:id])
    if project.user != current_user
      redirect to '/'
    else 
      project.destroy
      redirect "/projects"
    end
  end

end