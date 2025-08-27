class UsersController < ApplicationController

	def new
		@user = User.new(role: params[:role])
	end

  def create
    
    @user = User.create(user_params)

    if @user.persisted?
      if @user.role == "owner"
        session[:user_id] = @user.id
        redirect_to new_shop_path(owner_id: @user.id), notice: "Welcome, Owner! Please register your shop."
      else
        redirect_to shops_path, notice: "Thanks for signing up!"
      end
    else
      render :new, status: :unprocessable_entity
    end

  end


	private

	def user_params
    params.require(:user).permit(:name, :email, :role, :password)
  end
	
end