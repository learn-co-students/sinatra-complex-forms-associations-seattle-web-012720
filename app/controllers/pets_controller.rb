class PetsController < ApplicationController

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets' do
    @pets = Owner.all
    erb :'/pets/index' 
  end

  post '/pets' do
    @pet = Pet.create(name: params["pet"]["name"])
    if !params["owner"]["name"].empty?
      Owner.create(name: params["owner"]["name"]).pets << @pet
    else
      Owner.find_by(id: params["owner"]["ids"]).pets << @pet
    end
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find_by(id: params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.owner = nil
    @pet.update(name: params["pet"]["name"])
      if !params["owner"]["name"].empty?
        Owner.create(name: params["owner"]["name"]).pets << @pet
      else
        Owner.find_by(id: params["owner"]["ids"][0]).pets << @pet
      end
      redirect "pets/#{pet.id}"
  end
end