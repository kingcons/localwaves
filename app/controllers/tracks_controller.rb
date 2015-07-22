class TracksController < ApplicationController
  def index
    @user = User.find(params[:id])
    @tracks = @user.tracks
    render 'index.json.jbuilder', status: :ok
  end

  def search
    render json: { message: "Not yet implemented." }
  end
end
