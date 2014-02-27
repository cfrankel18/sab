class RolesController < ApplicationController

  before_action :check_signed_in_user
  before_action :check_is_member
  before_action :check_unique_role, only:[:new]

def new
	@role = Role.new(user_id: current_user.id)
end

def create
	weekend = Weekend.find(params[:weekend_id])
	event = weekend.events.find(params[:event_id])
	@role = event.roles.new(role_params)
	if @role.save
		flash[:notice] = 'Signed up.'
		redirect_to weekend_event_path(weekend_id:weekend.id, id:event.id)
	else
		render 'new'
	end
end

def edit
	@role = Role.find(params[:id])
end

def update
	@role = Role.find(params[:id])
		if @role.update_attributes(role_params)
			flash[:notice] = 'Duties updated.'
			redirect_to weekend_event_path(weekend_id:Event.find(@role.event_id).weekend_id, id:@role.event_id)
		else
			render 'edit'
		end
end

def destroy
	@role = Role.find(params[:id])
		ei = @role.event_id
		@role.destroy
		flash[:notice] = 'Duties cancelled.'
		redirect_to weekend_event_path(weekend_id:Event.find(ei).weekend_id, id:ei)
end

private

def role_params
params
	.require(:role)
	.permit(:will_setup, :will_cleanup, :user_id, :event_id)
end

def check_signed_in_user
  unless signed_in?
    flash[:alert] = 'Please sign in first.'
    redirect_to signin_url
  end
end

def check_is_member
  if !current_user.is_member
    redirect_to root_path
  end
end

def check_unique_role
	wi = params[:weekend_id]
	ei = params[:event_id]
	if (Role.where(event_id: ei, user_id: current_user.id).take != nil)
		redirect_to edit_weekend_event_role_path(weekend_id: wi, event_id: ei, id: 		Role.where(event_id: ei, user_id: current_user.id).take.id)
	end
end

end
