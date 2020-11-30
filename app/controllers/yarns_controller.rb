class YarnsController < ApplicationController

  # GET: /yarns
  get "/yarns" do
    erb :"/yarns/index.html"
  end

  # GET: /yarns/new
  get "/yarns/new" do
    erb :"/yarns/new.html"
  end

  # POST: /yarns
  post "/yarns" do
    redirect "/yarns"
  end

  # GET: /yarns/5
  get "/yarns/:id" do
    erb :"/yarns/show.html"
  end

  # GET: /yarns/5/edit
  get "/yarns/:id/edit" do
    erb :"/yarns/edit.html"
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
