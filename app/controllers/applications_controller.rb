class ApplicationsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_is_applicant?

	def new
		@tender = Tender.find(params[:tender_id])
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

end
