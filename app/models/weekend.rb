class Weekend < ActiveRecord::Base
  attr_accessible :date, :picture

  has_many :events
end
