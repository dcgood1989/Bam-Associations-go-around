class AppointmentsController < ApplicationController

  def index
    @user = current_user
    @appointments = Appointment.all
  end

  def new
    @user = User.find(params[:user_id])
    @appointment = @user.appointments.new
  end

  def create
    @user = current_user
    @appointment = @user.appointments.new(appointment_params.merge(user_id: @user.id))
    if @appointment.save

      flash[:notice] = "Appointment Created with Dr. Vader"
      redirect_to appointments_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @appointment = @user.appointments.find(params[:id])
  end

  def update
    @user = current_user
    @appointment = @user.appointments.find(params[:id])
    @appointment.update(appointment_params)
      flash[:notice] = "Appointment Updated with Dr. Vader"
      redirect_to appointments_path

  end

  def appointment_params
    params.require(:appointment).permit(:date)
  end

end
