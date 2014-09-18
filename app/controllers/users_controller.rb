class UsersController < ApplicationController

  before_action :require_signin, only: [:edit, :update, :destroy]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  	  sign_in @user
  	  flash[:success] = 'Your account is successfully created!'
  	  redirect_to user_path(@user)
  	else
  	  render 'new'
  	end
  end

  def edit
   
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your profile has been successfully updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name} has been deleted"
    redirect_to users_path
  end

  private
 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_signin
    unless signed_in?
      store_location
      flash[:warning] = 'Please sign in' 
      redirect_to signin_path
    end
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_path
    end
  end

end
