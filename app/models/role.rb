class Role < ActiveRecord::Base
	attr_accessible :will_setup, :will_cleanup, :event_id, :duser_id
	
	belongs_to :event
	belongs_to :duser
end
