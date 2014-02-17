class EventsController < ApplicationController

#before_validates :set_event_weekend_id

def index
	@events = Weekend.find(params[:weekend_id]).events.order(:title)
end

def show
	@event = Event.find(params[:id])
end

def new
	@event = Event.new
end

def create
	#@event = Event.new(event_params, :weekend_id => params[:id])
	#debugger
	weekend = Weekend.find(params[:weekend_id])
	@event = weekend.events.new(event_params)
	if @event.save
		flash[:success] = 'Event saved!'
		redirect_to weekend_path(id:weekend)
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
		redirect_to weekend_events_path
	else
		render 'edit'
	end
end

def destroy
	@event = Event.find(params[:id])
	wi = @event.weekend_id
	@event.destroy
	flash[:success] = 'Event destroyed :('
	redirect_to weekend_path(id:wi)
end

private

def event_params
params
	.require(:event)
	.permit(:title, :description, :day, :time)
end

def set_weekend_event_id
	self.weekend_id = params[:id]
end

end
