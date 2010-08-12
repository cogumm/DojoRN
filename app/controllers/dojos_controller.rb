class DojosController < ApplicationController
  # Método index
  def index
    @dojos = Dojo.all
  end

  # Método new
  def new
    @dojo = Dojo.new
  end
  
  # Método show
  def show
    @dojo = Dojo.find(params[:id])
  end
  
  # Método create
  def create
    @dojo = Dojo.new(params[:dojo])

    if @dojo.save
      redirect_to @dojo
    else
      render :action => :new
    end
  end

  # Método edit
  def edit
    @dojo = Dojo.find(params[:id])
  end

  # Método update
  def update
    @dojo = Dojo.find(params[:id])

    if @dojo.update_attributes(params[:dojo])
      redirect_to @dojo
    else
      render :action => :edit
    end
  end
end
