ActiveAdmin.register Application do

  permit_params :utf8, :authenticity_token, :cover, :proposal, :estimated_budget, :estimated_time, :status, :user_id, :tender_id, :commit


  config.filters = false


  scope :all, default: true

  scope "Pending Applications" do |applications|
    applications = Application.pending_applications
  end

  scope "Selected Applications" do |applications|
    applications = Application.selected_applications
  end

  scope "Rejected Applications" do |applications|
    applications = Application.rejected_applications
  end

  form do |f|
    inputs 'Application Details' do
      input :user_id, :as => :select, :collection => User.get_applicants.map{|u|["#{u.id}. #{u.full_name} (#{u.email})",u.id]}
      input :tender_id, :as => :select, :collection => Tender.available_tenders.map{|t| ["#{t.id}. #{t.title}",t.id]}
      input :cover
      input :proposal
      input :estimated_budget, :input_html => {:placeholder => "Give your estimated budget for tender here.!"}
      input :estimated_time, :input_html => {:placeholder => "Give your estimated time duration here.!"}
      input :status, :input_html => {:disabled => true}
    end
    actions
  end    

end
