class User < ActiveRecord::Base
    has_many :projects
    has_many :yarns
    has_secure_password

    validates :username, presence: true
    validates :password_digest, :email, presence: true
    validates :email, uniqueness: true
end
