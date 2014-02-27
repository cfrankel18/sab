class Role < ActiveRecord::Base
	attr_accessible :will_setup, :will_cleanup, :event_id, :user_id
	
	belongs_to :event
end
