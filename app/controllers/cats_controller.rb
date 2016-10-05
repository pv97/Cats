class CatsController < ApplicationController
  def index
    @cats = Cat.all
    # render json: @cats
  end

  def show
    @cat = Cat.find(params[:id])
    @rental_requests = @cat.cat_rental_requests.order(:start_date)
    if @cat.nil?
      render status: :not_found
    else
      # render json: @cat
    end
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.nil?
      render status: :not_found
    else
      if @cat.update(cat_parameters)
        redirect_to cat_url(@cat.id)
      else
        render status: :unprocessable_entity
      end
    end
  end

  def create
    cr = Cat.new(cat_parameters)
    if cr.save
      redirect_to cats_url
    else
      render status: :unprocessable_entity
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    if @cat.nil?
      render status: :not_found
    else
      #pass
    end
  end

  def new
    @cat = Cat.new
  end

  private

  def cat_parameters
    params.require(:cat).permit(:color, :name, :birth_date, :sex, :description)
  end

end
