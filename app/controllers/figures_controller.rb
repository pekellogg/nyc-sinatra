class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index' 
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new' 
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])

    @figure.titles << Title.create(name: params["title"]["name"]) unless params["title"]["name"].blank?
    @figure.landmarks << Landmark.create(name: params["landmark"]["name"]) unless params["landmark"]["name"].blank?

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do 
    @figure = Figure.find_by(id: params["id"])
    @figure.update(params["figure"])

    @figure.titles << Title.create(params["title"]) unless params["title"]["name"].blank?
    @figure.landmarks << Landmark.create(params["landmark"]) unless params["landmark"]["name"].blank?
    
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end
