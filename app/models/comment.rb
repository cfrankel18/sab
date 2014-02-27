class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :event_id

  belongs_to :event 
  belongs_to :user

  validates :content, presence: true

end
