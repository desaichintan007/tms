ActiveAdmin.register Tender do

  permit_params :utf8, :authenticity_token, :title, :description, :start_date, :end_date, :notice_duration, :minimum_budget, :user_id, :commit

  config.filters = false

end
