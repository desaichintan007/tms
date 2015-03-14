class TmsMailer < ActionMailer::Base
  default from: "server@tms.com"

  def application_created_mail_for_issuer(application,applicant,tender,issuer)
  	@application = application
  	@applicant = applicant
  	@tender = tender
  	@issuer = issuer
  	mail(to: @issuer.email, subject: "You have got an application submitted by #{@applicant.email}")
  end

  def application_created_mail_for_applicant(application,applicant,tender,issuer)
  	@application = application	
  	@applicant = applicant
  	@tender = tender
  	@issuer = issuer
  	mail(to: @applicant.email, subject: "You have submitted your application on tender #{@tender.title}")
  end

  def tender_created()
  end

end
