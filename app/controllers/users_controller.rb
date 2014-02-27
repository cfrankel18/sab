class UsersController < ApplicationController

  before_action :check_signed_in_user, only:[:edit, :update, :destroy]
  before_action :check_correct_user, only:[:edit, :update, :destroy]
  before_action :check_is_member, only:[:index, :show, :edit, :update, :destroy]

  def index
	@users = User.all
  end

  def new
	@user = User.new(is_member: false)
  end

  def edit
	@user = User.find(params[:id])
  end

  def show
	@user = User.find(params[:id], :include => :comments)
  end

  def create
	@user = User.new(user_params)
	    if @user.save
		  sign_in @user
	      flash[:notice] = "Account created! Welcome!"
	      redirect_to @user
	    else
	      render 'new'
	    end
  end

  def update
	@user = User.find(params[:id])
	    if @user.update_attributes(user_params)
	      flash[:notice] = 'User updated.'
	      redirect_to users_path
	    else
	      render 'edit'
	    end
  end

  def destroy
	User.find(params[:id]).destroy
	    flash[:notice] = 'User deleted.'
	    redirect_to users_path
  end

  def make_member
	@user = User.find(params[:user_id])
	im = !@user.is_member
	@user.update_attribute(:is_member, im)
	flash[:notice] = "Board member status updated."
	redirect_to users_path
  end

  private
  
  def user_params
    params
      .require(:user)
      .permit(:first, :last, :email, :password, :password_confirmation, :is_member)
  end

  def check_signed_in_user
    unless signed_in?
      flash[:alert] = 'Please sign in first.'
      redirect_to signin_url
    end
  end
  
  def check_correct_user
    @user = User.find(params[:id])
    redirect_to signin_path unless current_user?(@user) || current_user.is_member
      end

  def check_is_member
	if !current_user.is_member
		redirect_to root_path
	end
  end

end
