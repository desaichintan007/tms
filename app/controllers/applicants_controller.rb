class ApplicantsController < ApplicationController
	before_action :authenticate_user!
	before_filter :check_is_applicant?

	def dashboard
	end

	def check_is_applicant?
		unless is_applicant?
			flash[:error] = "You are not an Applicant, so you can not access this page.!"
			redirect_to root_path
		end
	end
end
