class Event < ActiveRecord::Base
  attr_accessible :title, :description, :day, :time, :weekend_id

  #has_many :comments, :ratings
  belongs_to :weekend
  
end
