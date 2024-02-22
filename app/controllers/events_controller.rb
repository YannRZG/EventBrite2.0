class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :register]

  def index
    @events = Event.all
  end

  def show 
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to events_path, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def register
    @event = Event.find(params[:id])
    @attendance = Attendance.new(user_id: current_user.id, event_id: @event.id)

    if @attendance.save
      redirect_to @event, notice: 'You have successfully registered for the event.'
    else
      redirect_to @event, alert: 'Failed to register for the event.'
    end
  end

  private

  def event_params
    params.require(:event).permit(:admin_id, :title, :start_date, :duration, :description, :price, :location)
  end
end