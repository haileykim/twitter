class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:email].downcase)
  	if user && user.authenticate(params[:password])
  		sign_in(user)
  		flash[:success] = "Welcome back, #{user.name}!"
  		redirect_to user
  	else
  	  flash.now[:danger] = 'Invalid email of password'
  	  render 'new'
  	end

  end

  def destroy
  	sign_out
  	flash[:success] = "Your account has been deleted"
  	redirect_to root_url
  end
  
end
