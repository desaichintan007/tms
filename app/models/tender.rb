class Tender < ActiveRecord::Base

	# Associations
	belongs_to :user
	has_many :applications

	# Validations
	validates_presence_of :title, :description, :start_date, :end_date, :notice_duration, :minimum_budget, :user_id

	# Scopes
	scope :previous_tenders, -> { where("end_date < (?)",Date.today) }
	scope :upcoming_tenders, -> { where("start_date > (?)",Date.today) }
	scope :available_tenders, -> { where("end_date >= (?) AND (?) >= start_date",Date.today,Date.today) }
	scope :notice_period_tenders, -> { where("start_date-notice_duration <= (?) AND (?) <= start_date",Date.today,Date.today) }

	def is_previous?
		end_date < Date.today
	end

	def is_active?
		end_date >= Date.today && Date.today >= start_date
	end

	def is_upcoming?
		start_date > Date.today
	end

end
