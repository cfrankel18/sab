class RatingsController < ApplicationController

before_action :check_signed_in_user
before_action :check_unique_rating, only:[:new]

def new
	@rating = Rating.new(duser_id: current_duser.id)
end

def create
	event = Event.find(params[:event_id])
	@rating = event.ratings.new(rating_params)
	if @rating.save
		flash[:notice] = 'Event rated.'
		redirect_to weekend_event_path(weekend_id: Event.find(event.id).weekend_id, id: event.id)
	else
		render 'new'
	end
end

def edit
	@rating = Rating.find(params[:id])
end

def update
	@rating = Rating.find(params[:id])
	if @rating.update_attributes(rating_params)
		flash[:notice] = 'Rating updated.'
		redirect_to weekend_event_path(weekend_id:Event.find(@rating.event_id).weekend_id, id:@rating.event_id)
	else
		render 'edit'
	end
end

def destroy
	@rating = Rating.find(params[:id])
	ei = @rating.event_id
	@rating.destroy
	flash[:notice] = 'Rating destroyed.'
	redirect_to weekend_event_path(weekend_id: Event.find(ei).weekend_id, id: ei)
end

private

def rating_params
params
	.require(:rating)
	.permit(:value, :duser_id)
end

  def check_signed_in_user
    unless duser_signed_in?
      flash[:alert] = 'Please sign in first.'
      redirect_to signin_url
    end
  end

  def check_unique_rating
  	ei = params[:event_id]
  	wi = params[:weekend_id]
  	if(Rating.where(event_id: ei, duser_id: current_duser.id).take != nil)
  		#flash[:alert] = 'You\'ve already rated this event'
  		redirect_to edit_weekend_event_rating_path(weekend_id: wi, event_id: ei, id:Rating.where(event_id: ei, duser_id: current_duser.id).take.id)
  	end
  end	

end
