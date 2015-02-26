class TmsMailer < ActionMailer::Base
  default from: "server@tms.com"

  def send_mail
  	mail(to: "aaaaaaaa@yopmail.com", subject: 'Welcome to My Awesome Site')
  end

end
