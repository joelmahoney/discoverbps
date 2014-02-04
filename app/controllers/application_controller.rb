class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_student
  helper_method :current_user_students
  helper_method :student_preference_categories
  # after_filter :store_location

  private
  
  def current_student
  	if session[:current_student_id].present?
	  	Student.find(session[:current_student_id]) rescue nil
	  end
  end

  def current_user_students
  	if current_user
      return current_user.students.verified
    elsif session[:session_id].present?
      return Student.verified.where(session_id: session[:session_id]).order(:first_name)
    else
      return []
    end
  end

  def student_preference_categories
  	PreferenceCategory.preference_panel.grade_level_categories(current_student.try(:grade_level))
  end

	# def store_location
	#  # store last url - this is needed for post-login redirect to whatever the user last visited.
	#     if (request.fullpath != "/users/sign_in" && \
	#         request.fullpath != "/users/sign_up" && \
	#         request.fullpath != "/users/password" && \
	#         !request.xhr?) # don't store ajax calls
	#       session[:previous_url] = request.fullpath 
	#     end
	# end

	def after_sign_out_path_for(resource_or_scope)
	  root_url
	end

	def after_sign_up_path_for(resource)
	  root_path
	end

	def after_sign_in_path_for(resource)
		current_student.update_attributes(user_id: current_user.id) if current_student.present? && current_student.user_id.blank?
	  schools_url
	end
end
