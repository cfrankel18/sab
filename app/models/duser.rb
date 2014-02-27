class Duser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :is_member, 
					:remember_me, :first_name, :last_name

  has_many :comments
  has_many :ratings
  has_many :roles
  has_many :suggestions
  
  validates :first_name, :last_name, presence:true, length: { maximum: 50 }
  VALID_ANDOVER_EMAIL = /\A[a-z\d\-.]+@andover.edu\z/i
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_ANDOVER_EMAIL },
                    uniqueness: { case_sensitive: false }
end
