class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLE = ["Admin","Applicant","Issuer"]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :tenders

  validates_presence_of :first_name, :last_name, :address, :contact


  def	is_issuer?
  	return (self.role==ROLE[2] ? true : false)
  end

  def is_applicant?
  	return (self.role==ROLE[1] ? true : false)
  end

end
