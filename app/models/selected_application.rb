class SelectedApplication < ActiveRecord::Base
	belongs_to :tender
	belongs_to :application

	validates :tender_id, uniqueness: { scope: :application_id, message: "You have already selected this application.!" }

	after_create do 
		self.application.update_attributes(:status => Application::STATUS[1])
	end

	before_destroy do
		self.application.update_attributes(:status => Application::STATUS[2])
	end
end
