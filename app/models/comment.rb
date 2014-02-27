class Comment < ActiveRecord::Base
  attr_accessible :content, :duser_id, :event_id

  belongs_to :event 
  belongs_to :duser

  validates :content, presence: true

end
