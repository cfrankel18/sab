class Rating < ActiveRecord::Base
  attr_accessible :value, :duser_id, :event_id

  belongs_to :event
  belongs_to :duser

  validates :value, presence: true
end
