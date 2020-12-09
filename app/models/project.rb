class Project < ActiveRecord::Base
    has_many :yarns
    belongs_to :user

    validates :name, :category, :knit_time, :status, presence: true
end
