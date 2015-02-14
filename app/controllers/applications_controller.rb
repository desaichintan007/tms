class ApplicationsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_is_applicant?, :except => [:show]
	before_action :get_tender, :only => [:new, :show]
	before_action :check_tender_availability, :only => [:new]
	before_action :get_application, :only => [:show]
	before_action :check_authorised_user, :only => [:show]

	def new
		@application = current_user.applications.build(:tender => @tender)
	end

	def create
		@tender = Tender.find(application_params[:tender_id])
		@application = Application.new(application_params)
		if @application.save
			flash[:success] = "Your application is submitted successfully.!"
			redirect_to active_tenders_path
		else
			flash[:error] = "Your application can not be submitted because : #{@application.errors.full_messages.to_sentence}"
			render :new
		end	
	end

	def show
	end

	protected

	def check_is_applicant?
		unless is_applicant?
			flash[:error] = "You are not an Applicant, so you can not access this page.!"
			redirect_to root_path
		end
	end

	def application_params
		params.require(:application).permit(:user_id,:tender_id,:cover,:proposal,:estimated_budget,:estimated_time)
	end

	def get_tender
		@tender = Tender.find(params[:tender_id])
	end

	def get_application
		@application = Application.find(params[:id])
		@applicant = @application.user
	end

	def check_tender_availability
		if @tender.is_upcoming?
			flash[:error] = "This tender '#{@tender.title}' is not active yet.!"
			redirect_to root_path
		end
	end

	def check_authorised_user
		@user = current_user rescue nil
		unless (@tender.user == @user) || (@user == @applicant)
			flash[:error] = "Unfortunately, You can not see this application.!"
			redirect_to root_path
		end
	end

end
