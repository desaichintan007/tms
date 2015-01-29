class TendersController < ApplicationController

	before_action :check_issuer?, :only => [:new, :create, :index]

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

end
