class Event < ActiveRecord::Base
  attr_accessible :title, :description, :day, :time

  #has_many :comments, :ratings
  belongs_to :weekend
  
  validates :weekend_id, :presence=>true
  
end
