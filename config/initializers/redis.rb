uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
# REDIS = Redis.new(url: uri)
Resque.redis = REDIS
