class SuggestionsController < ApplicationController

before_action :check_signed_in_user
#before_action :check_correct_user, only:[:edit, :update, :destroy]

def index
	@suggestions = Suggestion.all
end

def show
	@suggestion = Suggestion.find(params[:id])
end

def new
	@suggestion = Suggestion.new
end

def create
	@suggestion = Suggestion.new(suggestion_params)
    if @suggestion.save
      flash[:notice] = "Idea suggested."
      redirect_to suggestions_path
    else
      render 'new'
    end
end

def edit
	@suggestion = Suggestion.find(params[:id])
end

def update
	@suggestion = Suggestion.find(params[:id])
	    if @suggestion.update_attributes(suggestion_params)
	      flash[:notice] = 'Suggestion updated.'
	      redirect_to suggestion_path
	    else
	      render 'edit'
	    end
end

def destroy
	Suggestion.find(params[:id]).destroy
	    flash[:notice] = 'Suggestion deleted.'
	    redirect_to suggestions_path
end

private

def suggestion_params
    params
		.require(:suggestion)
		.permit(:title, :content)
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
