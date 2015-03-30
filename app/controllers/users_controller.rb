class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :fetch_user, :only => [:edit, :update, :show]
	before_action :check_user_authentication, :only => [:edit, :update]

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

	def show
	end

	protected

	def user_params
		params.require(:user).permit(:id, :first_name, :last_name, :address, :contact, :website, :description)
	end

	def fetch_user
		@user = User.find(params[:id])
	end

	def check_user_authentication
		unless @user == current_user
			flash[:error] = "You are not allowed to access this page."
			redirect_to root_path
		end
	end

end
