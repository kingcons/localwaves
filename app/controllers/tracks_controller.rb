class TracksController < ApplicationController
  def index
    @user = User.find(params[:id])
    @tracks = @user.tracks
    render 'index.json.jbuilder', status: :ok
  end

  def completion
    @places = User.distinct.pluck(:city, :state)
    @genres = Track.distinct.pluck(:genre)
    render json: {
      cities: @places.map(&:first),
      states: @places.map(&:second),
      genres: @genres
     }, status: :ok
  end

  def search
    if params[:city] && params[:state]
      @users = User.where(city: params[:city], state: params[:state])
      @tracks = Track.joins(:user).where("users.id" => @users)
      render 'index.json.jbuilder', status: :ok
    else
      render json: { message: "Missing City or State parameters." },
        status: :unprocessable_entity
    end
  end
end
