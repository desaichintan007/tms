class BackendJob
  include SuckerPunch::Job

  def application_created(application,applicant,tender,issuer)
  	TmsMailer.application_created_mail_for_applicant(application,applicant,tender,issuer).deliver
  	TmsMailer.application_created_mail_for_issuer(application,applicant,tender,issuer).deliver  	
  end

  # Create notification when issuer receive an application for tender by any applicant
  def create_notifications_on_submitting_application(application,applicant,tender,issuer)
  	applicant_message = "You have submitted application on tender #{tender.title} successfully."
  	issuer_message = "You have received an application on tender #{tender.title} by applicant #{applicant.full_name}"
  	applicant_url = "/applications/#{application.id}?tender_id=#{tender.id}"
  	issuer_url = "/applications/#{application.id}?tender_id=#{tender.id}"
  	applicant.notifications.build(message: applicant_message, intended_for: Notification::INTENDED_FOR[2], url:applicant_url).save
  	issuer.notifications.build(message: issuer_message, intended_for: Notification::INTENDED_FOR[2], url:issuer_url).save
  end

  # Create notfication for all applicants when a tender is created
  def create_notification_on_creating_tender(tender,issuer)
    Notification.create(
      message: "Tender '#{tender.title}' is created by #{issuer.full_name}. Tender is available for you from #{tender.start_date>Time.now ? tender.start_date : "now"}.",
      intended_for: Notification::INTENDED_FOR[0],
      url: "/tenders/#{tender.id}"
    )
  end

end