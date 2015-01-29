class ProjectsController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]
	before_action :get_project, :only => [:show]

	def index
		@projects = current_user.projects
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
	end

	def destroy
	end

	protected

	def project_params
		params.require(:project).permit(:title,:description,:start_date,:end_date,:associated_people,:budget,:user_id)
	end

	def get_project
		@project = Project.find(params[:id])
		@project_images = @project.pictures
	end
end
