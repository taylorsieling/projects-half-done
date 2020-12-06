class User < ActiveRecord::Base
    has_many :projects
    has_many :yarns
    has_secure_password
end
