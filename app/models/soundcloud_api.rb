class SoundcloudApi
  attr_reader :api

  # https://api.soundcloud.com/oauth2/token

  def initialize(opts={})
    defaults = {
      client_id: ENV['SOUNDCLOUD_CLIENT_ID'],
      client_secret: ENV['SOUNDCLOUD_CLIENT_SECRET'],
      redirect_uri: ENV['SOUNDCLOUD_REDIRECT_URI']
    }
    @api = Soundcloud.new(defaults.merge(opts))
  end
end
