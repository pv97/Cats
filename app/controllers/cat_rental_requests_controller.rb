class CatRentalRequestsController < ApplicationController
  def index
    cat = Cat.find(params[:cat_id])
    @cat_rental_requests = cat.cat_rental_requests
    render json: @cat_rental_requests
  end

  def new
    @cats = Cat.all
  end

  def create
    cr = CatRentalRequest.new(cat_rental_requests_parameters)
    if cr.save
      redirect_to cat_url
    else
      render status: :unprocessable_entity
    end
  end

  def show
    @crr = CatRentalRequest.find(params[:id])
    if @crr.nil?
      render status: :not_found
    else
      # render json: @cat
    end
  end

  def approve
    crr = CatRentalRequest.find(params[:id])
    crr.approve!
    redirect_to :back
  end

  def deny
    crr = CatRentalRequest.find(params[:id])
    crr.deny!
    redirect_to :back
  end

  private

  def cat_rental_requests_parameters
    params.require(:cat_rental_request).permit(:cat_id,:start_date,:end_date)
  end
end
