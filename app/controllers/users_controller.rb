class UsersController < ApplicationController

	def new
		@user = User.new(role: params[:role])
	end

  def create
      @user = User.create(user_params)

			if @user.persisted?
				redirect_to customers_dashboard_path, notice: "Thanks for signing up!"
			else
				render :new , status: :unprocessable_entity 
	    end
  end


	private

	def user_params
    params.require(:user).permit(:name, :email, :role, :password)
  end
	
end