class Weekend < ActiveRecord::Base
  attr_accessible :date

  validates :date, uniqueness:true

  has_many :events
end
