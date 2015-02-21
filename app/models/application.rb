class Application < ActiveRecord::Base

	# Associations
	belongs_to :user
	belongs_to :tender
	has_one :selected_application

	# Constants
	STATUS = ["pending","selected","rejected"]

	# Validations
	validates :tender_id, uniqueness: { scope: :user_id, message: "You have already applied to this tender.!" }
	validates_presence_of :cover, :proposal, :estimated_time, :estimated_budget, :user_id, :tender_id

	
	def belongs_to_issuer?(user_id)
		return  tender.user.id == user_id ? true : false
	end
	
end
