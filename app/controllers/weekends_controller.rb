class WeekendsController < ApplicationController

before_action :check_signed_in_user
#before_action :check_correct_user, only:[:edit, :update, :destroy]
before_action :check_is_member, only:[:new, :create, :edit, :update, :destroy]

def index
	@weekends = Weekend.all.order(:date)
end

def show
	@weekend = Weekend.find(params[:id])
	@friday_events = @weekend.events.select { |event| event.day == "Friday"}
	@saturday_events = @weekend.events.select { |event| event.day == "Saturday"}
	@sunday_events = @weekend.events.select { |event| event.day == "Sunday"}
end

def new
	@weekend = Weekend.new
end

def create
	@weekend = Weekend.new(weekend_params)
    if @weekend.save
      flash[:notice] = "Weekend created."
      redirect_to weekends_path
    else
      render 'new'
    end
end

def edit
	@weekend = Weekend.find(params[:id])
end

def update
	@weekend = Weekend.find(params[:id])
	    if @weekend.update_attributes(weekend_params)
	      flash[:notice] = 'Weekend updated.'
	      redirect_to weekend_path
	    else
	      render 'edit'
	    end
end

def destroy
	Weekend.find(params[:id]).destroy
	    flash[:notice] = 'Weekend deleted.'
	    redirect_to weekends_path
end

private

def weekend_params
    params
		.require(:weekend)
		.permit(:date, :weekender)
end

def check_signed_in_user
    unless duser_signed_in?
      flash[:alert] = 'Please sign in first.'
      redirect_to signin_url
    end
end
  
def check_correct_user
    @user = User.find(params[:id])
    redirect_to signin_path unless current_duser?(@user)
end

 def check_is_member
	if !current_duser.is_member
		redirect_to root_path
	end
  end

end
