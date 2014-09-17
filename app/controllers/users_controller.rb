class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  	  flash[:success] = 'Your account is successfully created!'
  	  redirect_to user_path(@user)
  	else
  	  render 'new'
  	end
  end

  def update
  end

  def destroy
  end

  private
 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end