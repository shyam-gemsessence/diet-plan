class ApplicationController < ActionController::Base

    def authenticate_user
      unless current_user
        redirect_to root_path
      end
    end

    def current_user
      @current_user = User.find(session[:user_id]) if session[:user_id]
    end

    def ensure_customer
      unless current_user.role == 'customer'
        redirect_to root_path, alert: "Access denied."
      end
    end

    def ensure_owner
      redirect_to root_path unless current_user.role == "owner"
    end

    def destroy_session
     session[:user_id] = nil
    end


    helper_method :current_user
    helper_method :ensure_owner
    helper_method :ensure_customer
end
