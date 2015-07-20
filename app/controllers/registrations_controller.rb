class RegistrationsController < ApplicationController
  def create
    @user = User.new(email: params[:email],
                     username: params[:username],
                     password: params[:password],
                     password_confirmation: params[:password])
    if @user.save
      render :create, status: :created
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def reset
    @user = User.find_by!(username: params[:username])
    if @user.authenticate(params[:password])
      @user.regenerate_token!
      render :create, status: :accepted
    else
      render json: { message: "You don't have permission to reset token for: '#{params[:username]}'." },
        status: :unauthorized
    end
  end

  def destroy
    @user = User.find_by!(username: params[:username])
    if @user.authenticate(params[:password])
      @user.destroy!
      render json: { message: "User '#{params[:username]}' was destroyed." },
        status: :no_content
    else
      render json: { message: "Incorrect username or password." },
        status: :unauthorized
    end
  end
end
