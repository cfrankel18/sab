module SessionsHelper
  
  def sign_in(user)
    session[:user_id] = user.id
    self.current_user = user
  end
  
  def sign_out
    session[:user_id] = nil
    self.current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= (User.find(session[:user_id]) unless session[:user_id].nil? )
    #return @current_user
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def signed_in?
     not current_user.nil?
  end
  
end
