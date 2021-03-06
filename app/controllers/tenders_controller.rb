class TendersController < ApplicationController

	before_action :authenticate_user!, :except => [:show, :search_tender]
	before_action :check_issuer?, :only => [:new, :create, :index]
	before_action :get_tender, :only => [:show, :edit, :update, :destroy, :all_applications]
	before_action :is_tender_issuer?, :only => [:select_application] 

	def index
		@all_tenders = current_user.tenders
		@available_tenders = current_user.tenders.available_tenders
		@previous_tenders = current_user.tenders.previous_tenders
		@upcoming_tenders = current_user.tenders.upcoming_tenders
	end

	def new
		@tender = current_user.tenders.new
	end

	def create
		@tender = Tender.new(tender_params)
		if @tender.save
			flash[:success] = "Congratulations, Your tender created successfully..!"
			redirect_to root_path
		else
			flash[:error] = @tender.errors.full_messages.to_sentence
			render :new
		end		
	end

	def all_applications
		@applications = @tender.applications
	end

	def show
	end

	def edit
	end

	def update
		if @tender.update_attributes(tender_params)
			flash[:success] = "You updated tender : #{@tender.title} successfully.!"
			redirect_to root_path
		else
			flash[:error] = "Something went wrong.! #{@tender.errors.full_messages.to_sentence}"
			render :edit
		end
	end

	def destroy
		if @tender.destroy
			flash[:notice] = "Tender removed successfully.!!"
			else
			flash[:error] = "Something went wrong.! #{@tender.errors.full_messages.to_sentence}"
		end
		redirect_to tenders_path	 
	end

	def select_application
		if SelectedApplication.create(:tender_id => params[:tender_id], :application_id => params[:application_id])
			flash[:success] = "Application selected successfully.!"
		end	
		redirect_to :back
	end

	def reject_application
		sa = SelectedApplication.find_by(:tender_id => params[:tender_id], :application_id => params[:application_id])
		if sa.destroy
			flash[:success] = "Removed application from selected.!"
		end
		redirect_to :back
	end

	def search_tender
		@tenders = Tender.where("title like '%#{params[:search]}%'")
		respond_to do |format|
    		format.js
  		end
	end

	protected

	def check_issuer?
		unless is_issuer?
			flash[:error] = "You are not an issuer, You can not access this page."
			redirect_to root_path
		end
	end

	def tender_params
		 params.require(:tender).permit(:user_id,:title,:description,:minimum_budget,:start_date, :end_date,:notice_duration)
	end

	def get_tender
		@tender = Tender.find(params[:id]) rescue nil
		if @tender.blank?
			flash[:error] = "Sorry, the tender is not found. Might be removed from the Issuer.!"
			redirect_to dashboard_path
		end		
	end

	def is_tender_issuer?
		unless Tender.find(params[:tender_id]).user == current_user
			flash[:error] = "This Tender does not belongs to you. You can not perform action.!"
			redirect_to root_path
		end	
	end

end
