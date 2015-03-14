class Application < ActiveRecord::Base

	# Associations
	belongs_to :user
	belongs_to :tender
	has_one :selected_application
	after_create do
		## Send notification mail to applicant and issuer
		BackendJob.new.async.application_created(self,self.user,tender,tender.user) 

		## Create notifications for applicant and isser
		BackendJob.new.async.create_notifications_on_submitting_application(self,self.user,tender,tender.user)
	end

	# Constants
	STATUS = ["pending","selected","rejected"]

	# Validations
	validates :tender_id, uniqueness: { scope: :user_id, message: "You have already applied to this tender.!" }
	validates_presence_of :cover, :proposal, :estimated_time, :estimated_budget, :user_id, :tender_id

	# Scopes
	scope :pending_applications, -> { where("status = (?)",STATUS[0]) }
	scope :selected_applications, -> { where("status = (?)",STATUS[1]) }
	scope :rejected_applications, -> { where("status = (?)",STATUS[2]) }

	# Methods
	def belongs_to_issuer?(user_id)
		return  tender.user.id == user_id ? true : false
	end
	
end
