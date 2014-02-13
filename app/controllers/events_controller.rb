class EventsController < ApplicationController

before_validation :set_event_weekend_id

def index
	@events = Event.all.order(:title)
end

def show
	@event = Event.find(params[:id])
end

def new
	@event = Event.new
end

def create
	@event = Event.new(event_params, :weekend_id => params[:id])
	if @event.save
		flash[:success] = 'Event saved!'
		redirect_to weekend_events_path
	else
		render 'new'
	end
end

def edit
	@event = Event.find(params[:id])
end

def update
	@event = Event.find(params[:id])
	if @event.update_attributes(event_params)
		flash[:success] = 'Event updated!'
		redirect_to weekend_path
	else
		render 'edit'
	end
end

def destroy
	@event = Event.find(params[:id]).destroy
	flash[:success] = 'Event destroyed :('
	redirect_to weekend_path
end

private

def event_params
params
	.require(:event)
	.permit(:title, :description, :day, :time, :weekend_id)
end

def set_weekend_event_id
	self.weekend_id = params[:id]
end

end
