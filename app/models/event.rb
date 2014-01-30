class Event < ActiveRecord::Base
  attr_accessible :title, :description, :date

  has_many :comments, :ratings
  belongs_to :weekend
  
end
