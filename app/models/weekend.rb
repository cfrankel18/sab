class Weekend < ActiveRecord::Base
  attr_accessible :date

  has_many :events

  validates :date, uniqueness:true
end
