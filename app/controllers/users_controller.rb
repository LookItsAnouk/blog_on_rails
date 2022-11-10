class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :newpass]

  def show
    # @user = User.find(params[:id])
  end  
  
  def new
        @user = User.new
      end
    
    def create
        @user = User.new user_params
        if @user.save
          session[:user_id] = @user.id
          redirect_to root_path, notice: "Logged In!"
        else
          render :new
        end
    end

    def edit
      # @user = User.find(params[:id])
    end
    
    def update
      # @user = User.find(params[:id])
      if @user.update(edit_user_params)
        flash[:success]
      else
        flash[:alert] = user.errors.full_messages.join(", ")
      end
      redirect_to posts_path
    end

    def newpass
      # @user = User.find(params[:id])
    end

    def update_password
      @user = User.find(params[:id])
      if @user.authenticate(params[:user][:current_password])
        @user.update(password: params[:user][:new_password], password_confirmation: params[:user][:new_password_confirmation])
        if @user.valid?
          flash[:success]= "password changed"
          redirect_to posts_path
        else
          flash[:alert]= user.errors.full_messages.join(", ")
          redirect_to newpass_user_path
        end
      end
    end

    private
    
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :password_confirmation
        )
    end

    def edit_user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email
      )
    end

    def password_params
      params.require(:user).permit(
        :current_password,
        :password,
        :password_confirmation,
        :id
      )
  end
end


