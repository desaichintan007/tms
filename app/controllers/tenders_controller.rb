class TendersController < ApplicationController

	before_action :check_issuer?, :only => [:new, :create, :index]
	before_action :get_tender, :only => [:show, :edit, :update, :destroy]

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
		@tender = Tender.find(params[:id])
	end

end
