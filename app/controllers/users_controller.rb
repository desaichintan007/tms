class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :fetch_user, :only => [:edit, :update]

	def index
	end

	def edit		
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Updated Successfully..!"
			redirect_to root_path
		else
			flash[:error] = "Something Went Wrong, can not update your profile..!"
			redirect_to :back
		end
	end

	protected

	def user_params
		params.require(:user).permit(:id, :first_name, :last_name, :address, :contact, :website, :description)
	end

	def fetch_user
		@user = User.find(params[:id])
	end

end
