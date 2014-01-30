class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_secure_password

  before_save { |user| user.email = email.downcase }

  validates :is_confirmed?
  validates :board_member?

  validates :name, presence:true, length: { maximum: 50 }
  VALID_ANDOVER_EMAIL = /\A[a-z\d\-.]+@andover.edu\z/i
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_ANDOVER_EMAIL },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


end
