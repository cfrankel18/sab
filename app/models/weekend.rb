class Weekend < ActiveRecord::Base
  attr_accessible :date, :weekender

  has_attached_file :weekender, :styles => { :large => "700x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.jpg"

  validates_attachment_content_type :weekender, :content_type => /\Aimage\/.*\Z/

  has_many :events

  validates :date, uniqueness:true
end
