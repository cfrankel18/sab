class Suggestion < ActiveRecord::Base
	attr_accessible :title, :content, :user_id
	
	validates :title, presence: true
	validates :content, presence: true
end
