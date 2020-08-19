class User < ApplicationRecord
	attr_accessor :remember_token
	before_save :downcase_email
	attr_accessor :remember_token
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX },uniqueness: true
	validates :diachi, presence: true
	validates :gioitinh, presence: true
	validates :sinhnhat, presence: true					  
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	validate :check_date
	enum gioitinh: [:nam, :nu, :bede ]
	
	
	class << self
	     def digest(string)

			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
			BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end	


		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	def current_user?(user)
		user.present? && user == self
	end
	def remember
		self.remember_token = User.new_token
		update_attributes remember_digest: User.digest(remember_token)
	end
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
	def forget
		update_attributes remember_digest: nil

	end
	private
	def check_date
	 	if sinhnhat.present? && sinhnhat > Date.current
	 		errors.add(:sinhnhat, 'mày đến từ tương lai à')
	 		
	 	end	
	end	


	def downcase_email
          self.email = email.downcase 
    end
    
end

