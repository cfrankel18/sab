class RatingsController < ApplicationController

before_action :check_signed_in_user
#before_action :check_correct_user, only:[:edit, :update, :destroy]

def new
	@rating = Rating.new(user_id: current_user.id)
end

def create
	event = Event.find(params[:event_id])
	@rating = event.ratings.new(rating_params)
	if @rating.save
		flash[:notice] = 'Event rated.'
		redirect_to weekend_event_path(id:event)
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
		redirect_to weekend_event_path(id:@rating.event_id)
	else
		render 'edit'
	end
end

def destroy
	@rating = Rating.find(params[:id])
	ei = @rating.event_id
	@rating.destroy
	flash[:notice] = 'Rating destroyed.'
	redirect_to weekend_event_path(id:ei)
end

private

def rating_params
params
	.require(:rating)
	.permit(:value, :user_id)
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
