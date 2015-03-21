class Notification < ActiveRecord::Base
	INTENDED_FOR = ["applicants","issers","specific"]
	belongs_to :user

	scope :applicants_notifications, -> {where(:intended_for => INTENDED_FOR[0])}
	scope :issuers_notifications, -> {where(:intended_for => INTENDED_FOR[1])}
end
