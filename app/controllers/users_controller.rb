class UsersController < ApplicationController
  before_action :authenticate_with_token!, except: [:show]

  def show
    @user = User.find(params[:id])
    render 'show.json.jbuilder', status: :ok
  end

  def sync
    TrackImportJob.perform_later(current_user)
    render json: { message: "TrackImportJob has been queued." },
      status: :ok
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
    @user.destroy!

    render json: { message: "User '#{@user.username}' was destroyed." },
      status: :no_content
  end
end
