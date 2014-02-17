class CommentsController < ApplicationController

def new
	@comment = Comment.new
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
	.permit(:content)
end

end
