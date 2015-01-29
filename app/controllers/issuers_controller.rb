class IssuersController < ApplicationController
	before_action :authenticate_user!
	before_filter :check_is_issuer?

	def dashboard
	end

	def check_is_issuer?
		unless is_issuer?
			flash[:error] = "You are not an Issuer, so you can not access this page.!"
			redirect_to root_path
		end
	end
end