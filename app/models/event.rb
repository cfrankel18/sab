class Event < ActiveRecord::Base
  attr_accessible :title, :description, :day, :time

  has_many :comments
  has_many :ratings
  has_many :roles
  belongs_to :weekend
  
  validates :title, presence: true
  validates :description, presence: true
  validates :day, presence: true
  validates :time, presence: true
  
end
