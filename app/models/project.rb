class Project < ActiveRecord::Base
    has_many :yarns
    belongs_to :user
end
