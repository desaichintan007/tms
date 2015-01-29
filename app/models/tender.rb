class Tender < ActiveRecord::Base

	# Associations
	belongs_to :user

	# Validations
	validates_presence_of :title, :description, :start_date, :end_date, :notice_duration, :minimum_budget, :user_id

	# Scopes
	scope :previous_tenders, -> { where("end_date < (?)",Date.today) }
	scope :upcoming_tenders, -> { where("start_date > (?)",Date.today) }
	scope :available_tenders, -> { where("end_date >= (?) AND (?) >= start_date",Date.today,Date.today) }

end
