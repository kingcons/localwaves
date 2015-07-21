class RegistrationsController < ApplicationController
  # before_action :authenticate_with_token, only: [:oauth]

  def sign_up
    @user = User.new(email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password],
                     city: params[:city],
                     state: params[:state])
    if @user.save
      render 'create.json.jbuilder', status: :created
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def oauth_test
    # Purely for experimenting with Soundcloud gem.
    binding.pry
    # Sure enough, just calling exchange token once we have the code is easy as pie.
    # Unfortunately, the Soundcloud gem is a bit odd and this destructively
    # modifies the client instance we have. So I need a fuckin factory now. :-/
  end

  def login
    @user = User.find_by!(email: params[:email])
    if @user.authenticate(params[:password])
      render 'create.json.jbuilder', status: :ok
    else
      render json: { message: "Incorrect email or password." },
        status: :unauthorized
    end
  end

  def oauth
    if params[:code]
      @api = SoundcloudApi.new.api
      @api.exchange_token(code: params[:code])

      @user = User.find_by!(email: params[:state])
      user_data = @api.get('/me')
      @user.update(username: user_data.permalink,
                   soundcloud_token: @api.access_token,
                   refresh_token:    @api.refresh_token,
                   expires_at:       @api.expires_at,
                   artist_name:      user_data.artist_name)
      redirect_to "http://localhost:8000/#/home"
    else
      render json: { message: "No authorization code from soundcloud found!" },
        status: :unprocessable_entity
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
