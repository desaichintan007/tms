class Tender < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :title, :description, :start_date, :end_date, :notice_duration, :minimum_budget, :user_id
end
