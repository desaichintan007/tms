class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  ROLE = ["Admin","Applicant","Issuer"]
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :tenders
  has_many :applications
  has_many :notifications

  validates_presence_of :first_name, :last_name, :address, :contact
  scope :get_applicants, -> {where(:role => ROLE[1]).order(:id)}
  scope :get_issuers, -> {where(:role => ROLE[2]).order(:id)}

  def full_name
    [first_name,last_name].join(" ")
  end

  def	is_issuer?
  	return (self.role==ROLE[2] ? true : false)
  end

  def is_applicant?
  	return (self.role==ROLE[1] ? true : false)
  end

  def my_notifications
    if is_issuer?
      notifications+Notification.issuers_notifications
    else
      notifications+Notification.applicants_notifications
    end
  end

  def all_applications
    tenders.collect{|t| t.applications}.flatten
  end

end
