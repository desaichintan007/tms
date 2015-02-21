class Project < ActiveRecord::Base
	belongs_to :user
	has_many :pictures, :as => :imageable, :dependent => :destroy

	def belongs_to?(user_id)
		return  user.id == user_id ? true : false
	end
end
