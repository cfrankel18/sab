class User < ActiveRecord::Base
  attr_accessible :first, :last, :email, :password, :password_confirmation, :is_member

  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_create :create_remember_token

  #validates :is_confirmed?
  #validates :board_member?

  validates :first, :last, presence:true, length: { maximum: 50 }
  VALID_ANDOVER_EMAIL = /\A[a-z\d\-.]+@andover.edu\z/i
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_ANDOVER_EMAIL },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


def User.new_remember_token
	SecureRandom.urlsafe_base64
end

def User.encrypt(token)
	Digest::SHA1.hexdigest(token.to_s)
end

private

def create_remember_token
	self.remember_token = User.encrypt(User.new_remember_token)
end

end
