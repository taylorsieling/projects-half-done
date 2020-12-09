class Yarn < ActiveRecord::Base
    belongs_to :project
    belongs_to :user

    validates :brand, :name, :weight, :color, :quantity, presence: true
end
