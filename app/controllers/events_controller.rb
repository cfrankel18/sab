class EventsController < ApplicationController

before_action :check_signed_in_user
#before_action :check_correct_user, only:[:edit, :update, :destroy]

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
		flash[:notice] = 'Event saved.'
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
		flash[:notice] = 'Event updated.'
		redirect_to weekend_path(id:@event.weekend_id)
	else
		render 'edit'
	end
end

def destroy
	@event = Event.find(params[:id])
	wi = @event.weekend_id
	@event.destroy
	flash[:notice] = 'Event destroyed.'
	redirect_to weekend_path(id:wi)
end

private

def event_params
params
	.require(:event)
	.permit(:title, :description, :day, :time, :id)
end

  def check_signed_in_user
    unless signed_in?
      flash[:alert] = 'Please sign in first.'
      redirect_to signin_url
    end
  end
  
  def check_correct_user
    @user = User.find(params[:id])
    redirect_to signin_path unless current_user?(@user)
  end

end
