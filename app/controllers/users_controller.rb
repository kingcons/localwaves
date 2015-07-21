class UsersController < ApplicationController
  before_action :authenticate_with_token!

  def show
    @user = User.find(params[:id])
    render 'show.json.jbuilder', status: :ok
  end

  def reset
    @user = User.find(params[:id])
    if @user.authenticate(params[:password])
      @user.regenerate_token!
      render 'show.json.jbuilder', status: :accepted
    else
      render json: { message: "You don't have permission to reset token for: '#{params[:email]}'." },
        status: :unauthorized
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.authenticate(params[:password])
      @user.destroy!
      render json: { message: "User '#{params[:email]}' was destroyed." },
        status: :no_content
    else
      render json: { message: "Incorrect username or password." },
        status: :unauthorized
    end
  end
end
