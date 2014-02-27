class SessionsController < ApplicationController

def new
  @user = Duser.new(is_member: false)
end
  
def create
  super
end
  
def destroy
  super
end

end
