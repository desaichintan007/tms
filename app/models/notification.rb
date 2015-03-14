class Notification < ActiveRecord::Base
	INTENDED_FOR = ["applicants","issers","specific"]
	belongs_to :user
end
