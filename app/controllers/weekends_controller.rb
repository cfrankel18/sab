class WeekendsController < ApplicationController

def index
	@weekends = Weekend.all.order(:date)
end

def show
	@weekend = Weekend.find(params[:id])
	@events = @weekend.events
end

def new
	@weekend = Weekend.new
end

def create
	@weekend = Weekend.new(weekend_params)
    if @weekend.save
      flash[:success] = "weekend created"
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
	      flash[:success] = 'weekend updated'
	      redirect_to weekend_path
	    else
	      render 'edit'
	    end
end

def destroy
	Weekend.find(params[:id]).destroy
	    flash[:success] = 'user deleted'
	    redirect_to weekends_path
end

private

def weekend_params
    params
		.require(:weekend)
		.permit(:date)
  end

end
