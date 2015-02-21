class ProjectsController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show, :portfolio]
	before_action :get_project, :only => [:show, :edit, :update, :destroy]
	before_action :check_authority, :only => [:edit, :update, :destroy]

	def index
		@user = current_user
		@projects = current_user.projects
	end

	def portfolio
		@user = User.find(params[:user_id])
		@projects = @user.projects
		render :index
	end

	def show
	end

	def new
		@project = current_user.projects.new
	end

	def create
		project = Project.create(project_params)
		if project
			image = project.pictures.create(:image => params[:image])
			image.save
			flash[:success] = "Project added successfully..!"
		else
			flash[:error] = "Something went wrong..!"
		end		
		redirect_to projects_path
	end

	def edit
	end

	def update		
		if @project.update_attributes(project_params)
			if params[:image].present?
				@project_images.first.update_attributes(:image => params[:image])	
			end
			flash[:success] = "Project updated successfully.!"
		else
			flash[:error] = "Something went wrong. Can not update project details.!"
		end
		render :show
	end

	def destroy
		if @project.destroy
			flash[:success] = "Project deleted successfully.!"
		else	
			flash[:error] = "Something went wrong, can not delete project.!"
		end
		redirect_to :index
	end

	protected

	def project_params
		params.require(:project).permit(:title,:description,:start_date,:end_date,:associated_people,:budget,:user_id)
	end

	def get_project
		@project = Project.find(params[:id])
		@project_images = @project.pictures
	end

	def check_authority
		unless @project.user == current_user
			flash[:error] = "This project does not belongs to you, You can not perform action on it.!"
			redirect_to root_path
		end
	end
end
