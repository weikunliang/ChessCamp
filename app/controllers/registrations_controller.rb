class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
  end

  def show
  end

  def new
    @registration = Registration.new
    @registration.camp_id = params[:id] unless params[:id].nil?
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to @registration.camp, notice: "#{@registration.student.proper_name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to @registration.camp, notice: "#{@registration.student.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @registration.destroy
    redirect_to @registration.camp, notice: "#{@registration.camp.name} was removed from the system."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
    end

end
