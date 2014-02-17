class Rating < ActiveRecord::Base
  attr_accessible :value, :user_id, :event_id

  belongs_to :event
end
