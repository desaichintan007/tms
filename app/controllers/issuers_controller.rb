class IssuersController < ApplicationController
	before_action :authenticate_user!
	before_filter :check_is_issuer?

	def dashboard
		@notifications = current_user.my_notifications.sort_by{|n| n.created_at }.reverse || []
	end

	def check_is_issuer?
		unless is_issuer?
			flash[:error] = "You are not an Issuer, so you can not access this page.!"
			redirect_to root_path
		end
	end
end