class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def is_applicant?
    return current_user.is_applicant?
  end

  def is_issuer?
    return current_user.is_issuer?
  end 


	protected

	# Allow parameters for sign up
	def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :role, :first_name, :last_name, :address, :contact, :website, :description) }
	end

	# Set path to redirect after sign in
	def after_sign_in_path_for(resource)    
    if resource.class.table_name=="admin_users"
      admin_root_path
    elsif is_applicant?
    	dashboard_applicants_path
    elsif	is_issuer?
    	dashboard_issuers_path
    else
    	root_path
    end    
  end

end
