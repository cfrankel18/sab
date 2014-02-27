class DusersController < ApplicationController

  before_action :check_signed_in_user, only:[:edit, :update, :destroy]
  before_action :check_correct_user, only:[:edit, :update, :destroy]
  before_action :check_is_member, only:[:index, :show, :edit, :update, :destroy]

  def index
	@dusers = Duser.all
  end

  def new
	@user = Duser.new(is_member: false)
  end

  def edit
	@user = Duser.find(params[:id])
  end

  def show
	@user = Duser.find(params[:id], :include => :comments)
  end

  def create
	@user = Duser.new(user_params)
	    if @user.save
		  sign_in @user
	      flash[:notice] = "Account created! Welcome!"
	      redirect_to root_path
	    else
	      render 'new'
	    end
  end

  def update
	@user = Duser.find(params[:id])
	    if @user.update_attributes(user_params)
	      flash[:notice] = 'User updated.'
	      redirect_to root_path
	    else
	      render 'edit'
	    end
  end

  def destroy
	tod = Duser.find(params[:id])
	tod.comments.each do |c|
		c.destroy
	end
	tod.ratings.each do |r|
		r.destroy
	end
	tod.roles.each do |r|
		r.destroy
	end
	tod.suggestions.each do |s|
		s.destroy
	end
	tod.destroy
	flash[:notice] = 'User deleted.'
	redirect_to dusers_path
  end

  def make_member
	@user = Duser.find(params[:duser_id])
	im = !@user.is_member
	@user.update_attribute(:is_member, im)
	flash[:notice] = "Board member status updated."
	redirect_to dusers_path
  end

  private
  
  def user_params
    params
      .require(:duser)
      .permit(:first_name, :last_name, :email, :password, :password_confirmation, :is_member)
  end

  def check_signed_in_user
    unless duser_signed_in?
      flash[:alert] = 'Please sign in first.'
      redirect_to signin_url
    end
  end
  
  def check_correct_user
    @user = Duser.find(params[:id])
    redirect_to signin_path unless current_duser == @user || current_duser.is_member
      end

  def check_is_member
	if !current_duser.is_member
		redirect_to root_path
	end
  end

end
