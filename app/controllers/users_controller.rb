class UsersController < ApplicationController
  before_action :set_user, only: [:destroy, :edit, :update]

  def index
    @users = User.all
    if params[:search_by_name]
      @users = User.search_by_name(params[:search_by_name])
    else
      @users = User.all
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to action: 'index'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :phone)
  end
end
