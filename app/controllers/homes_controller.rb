class HomesController < ApplicationController
  
  def index
  	@active_tenders = Tender.available_tenders.order(:end_date).limit(10)
  	@upcoming_tenders = Tender.notice_period_tenders.order(:start_date).limit(10)
  end

  def all_active_tenders
  	@active_tenders = Tender.available_tenders.order(:end_date)
  end

  def all_upcoming_tenders
  	@upcoming_tenders = Tender.upcoming_tenders.order(:start_date)
  end

end
