class ApplicantsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_is_applicant?

	def dashboard
		@notifications = current_user.notifications rescue []
	end

	protected

	def check_is_applicant?
		unless is_applicant?
			flash[:error] = "You are not an Applicant, so you can not access this page.!"
			redirect_to root_path
		end
	end
end
