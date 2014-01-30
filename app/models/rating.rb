class Rating < ActiveRecord::Base
  attr_accessible :rating, :user_id

  belongs_to :event
end
