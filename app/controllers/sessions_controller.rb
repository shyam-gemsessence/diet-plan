class SessionsController < ApplicationController

    def new

      #check if user is signed in 
      if session[:user_id]
        if current_user.role == 'customer'
          redirect_to shops_path
        elsif current_user.role == 'owner'
          redirect_to owner_shop_path
        end
      end
    end

    def create
      @user = User.find_by( email: params[:email])

      #authenticate user and redirect according to role
      if @user && @user.authenticate(params[:password])
        flash[:notice] = "welcome back #{@user.name}"
        session[:user_id] = @user.id
        if @user.role == "owner"
         redirect_to owner_shop_path
        else
         redirect_to shops_path
        end
      else
        flash.now[:notice]="invalid credentials"
        render :new , status: :unprocessable_entity
      end
    end
    
    def destroy
     session[:user_id] = nil
     redirect_to root_path ,status: :see_other, notice: "you are now signed out"
    end

end
