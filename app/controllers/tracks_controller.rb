class TracksController < ApplicationController
  def by_user
    @user = User.find(params[:id])
    @tracks = @user.tracks
    render 'index.json.jbuilder', status: :ok
  end

  def index
    @page = params[:page] || 1
    @tracks = Track.includes(:user).page(@page)
    render 'index.json.jbuilder', status: :ok
  end

  def completion
    @states = User.distinct.pluck(:city, :state).group_by(&:second).map{|k, v| [k, v.map(&:first)]}.to_h
    @genres = Track.distinct.pluck(:genre)
    render 'completion.json.jbuilder', status: :ok
  end

  def search
    ## HHAAAAACKS
    if params[:city] && params[:state]
      @users = User.where(city: params[:city], state: params[:state])

      query = {"users.id" => @users}
      query.merge({"tracks.genre" => params[:genre]}) if params[:genre]

      @tracks = Track.joins(:user).where(query)
      render 'index.json.jbuilder', status: :ok
    elsif params[:state]
      @users = User.where(state: params[:state])

      query = {"users.id" => @users}
      query.merge({"tracks.genre" => params[:genre]}) if params[:genre]

      @tracks = Track.joins(:user).where(query)
      render 'index.json.jbuilder', status: :ok
    elsif params[:genre]
      @tracks = Track.where(genre: params[:genre])
      render 'index.json.jbuilder', status: :ok
    else
      render json: { message: "Missing City or State parameters." },
        status: :unprocessable_entity
    end
  end
end
