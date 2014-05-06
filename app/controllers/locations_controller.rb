class LocationsController < ApplicationController
  include ActionView::Helpers::NumberHelper
	before_action :set_location, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @active_locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_locations = Location.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @camps = @location.camps.chronological.to_a
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location, notice: "#{@location.name} location was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @location.update(location_params)
      redirect_to @location, notice: "#{@location.name} location was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    status = @location.destroy
    if status
      flash[:notice] = "#{@location.name} location was removed from the system."
      redirect_to locations_url
    else
      flash[:error] = "#{@location.name} could not be deleted because it is being used by a camp."
    end
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :street_1, :street_2, :city, :state, :zip, :max_capacity, :active)
    end
end
