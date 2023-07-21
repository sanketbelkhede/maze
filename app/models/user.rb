class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :mobile, uniqueness: true, presence: true , length: {minimum: 10, maximum: 10}, numericality: { only_integer: true }
    validates :email, uniqueness: true
    validates :email, presence: true
    validates :password, length: { minimum: 5, allow_nil: true}
    
    def password
        @password
    end

    def password=(raw)
        @password = raw
        self.password_digest = BCrypt::Password.create(raw)
    end

    def is_password?(raw)
        BCrypt::Password.new(password_digest).is_password?(raw)
    end


end
