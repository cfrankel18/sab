class Suggestion < ActiveRecord::Base
	attr_accessible :title, :content, :duser_id
	
	belongs_to :duser
	
	validates :title, presence: true
	validates :content, presence: true
end
