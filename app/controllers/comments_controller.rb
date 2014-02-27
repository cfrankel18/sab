class CommentsController < ApplicationController

before_action :check_signed_in_user
before_action :check_correct_user, only:[:edit, :update, :destroy]


def new
	@comment = Comment.new(duser_id: current_duser.id)
end

def create
	event = Event.find(params[:event_id])
	@comment = event.comments.new(comment_params)
	if @comment.save
		flash[:notice] = 'Comment saved.'
		redirect_to weekend_event_path(id:event)
	else
		render 'new'
	end
end

def edit
	@comment = Comment.find(params[:id])
end

def update
	@comment = Comment.find(params[:id])
	if @comment.update_attributes(comment_params)
		flash[:notice] = 'Comment updated.'
		redirect_to weekend_event_path(id:@comment.event_id)
	else
		render 'edit'
	end
end

def destroy
	@comment = Comment.find(params[:id])
	ei = @comment.event_id
	@comment.destroy
	flash[:notice] = 'Comment destroyed.'
	redirect_to weekend_event_path(id:ei)
end

private

def comment_params
params
	.require(:comment)
	.permit(:content, :duser_id, :event_id)
end

  def check_signed_in_user
    unless duser_signed_in?
      flash[:alert] = 'Please sign in first.'
      redirect_to signin_url
    end
  end
  
  def check_correct_user
    @user = Duser.find(Comment.find(params[:id]).duser_id)
    redirect_to signin_path unless current_duser == @user || current_duser.is_member
  end

 def check_is_member
	if !current_duser.is_member
		redirect_to root_path
	end
  end

end
