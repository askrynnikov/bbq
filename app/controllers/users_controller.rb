class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  # # GET /users
  # def index
  #   @users = User.all
  # end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # # GET /users/new
  # def new
  #   @user = User.new
  # end

  # GET /users/1/edit
  def edit
  end

  # # POST /users
  # def create
  #   @user = User.new(user_params)
  #
  #   if @user.save
  #     redirect_to @user, notice: 'User was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: I18n.t('controllers.users.updated')
    else
      render :edit
    end
  end

  # # DELETE /users/1
  # def destroy
  #   @user.destroy
  #   redirect_to users_url, notice: 'User was successfully destroyed.'
  # end

  private
    def set_current_user
      @user = current_user
    end

    def user_params
      # params.fetch(:user, {})
      params.require(:user).permit(:name, :email)
    end
end
