class User < ActiveRecord::Base
    has_many :projects
    has_many :yarns
    has_secure_password

    validates :username, presence: true
    validates :username, uniqueness: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :email, email: true
end
