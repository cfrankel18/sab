class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_duser!
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| 		u.permit(:email, :password, :password_confirmation, :first_name, :last_name)}
	devise_parameter_sanitizer.for(:account_update) {|u| 		u.permit(:email, :password, :password_confirmation, 
		:current_password, :first_name, :last_name)}
  end
end
