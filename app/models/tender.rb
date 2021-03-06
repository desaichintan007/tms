class Tender < ActiveRecord::Base

	# Associations
	belongs_to :user
	has_many :applications
	has_many :selected_applications

	after_create do 
		BackendJob.new.async.create_notification_on_creating_tender(self,user)
	end

	# Validations
	validates_presence_of :title, :description, :start_date, :end_date, :notice_duration, :minimum_budget, :user_id

	# Scopes
	scope :previous_tenders, -> { where("end_date < (?)",Date.today) }
	scope :upcoming_tenders, -> { where("start_date > (?)",Date.today) }
	scope :available_tenders, -> { where("end_date >= (?) AND (?) >= start_date",Date.today,Date.today) }
	scope :notice_period_tenders, -> { where("start_date-notice_duration <= (?) AND (?) <= start_date",Date.today,Date.today) }

	# Methods
	def is_previous?
		end_date < Date.today
	end

	def is_active?
		end_date >= Date.today && Date.today >= start_date
	end

	def is_upcoming?
		start_date > Date.today
	end

	def selected_application_ids
		return self.selected_applications.pluck(:application_id)
	end

	def statistics_for_line_chart
		data_hash = {}
		applications.each{ |a|
			data_hash[a.created_at.strftime("%Y-%m-%d")] = (data_hash[a.created_at.strftime("%Y-%m-%d")]+1) rescue 1			
		}		
		data_hash.to_a
	end

end
