class YarnsController < ApplicationController

  get "/yarns" do
    erb :"/yarns/index"
  end

  get "/yarns/new" do
    @projects = current_user.projects
    erb :"/yarns/new"
  end

  post "/yarns" do
    @yarn = Yarn.create(params[:yarn])
    @project = Project.find_by_id(params[:id])
    @project.yarns << @yarn
    binding.pry
    redirect "/yarns"
  end

  # GET: /yarns/5
  get "/yarns/:id" do
    erb :"/yarns/show"
  end

  # GET: /yarns/5/edit
  get "/yarns/:id/edit" do
    erb :"/yarns/edit"
  end

  # PATCH: /yarns/5
  patch "/yarns/:id" do
    redirect "/yarns/:id"
  end

  # DELETE: /yarns/5/delete
  delete "/yarns/:id/delete" do
    redirect "/yarns"
  end
end
