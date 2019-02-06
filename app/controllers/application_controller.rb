require './config/environment'


class ApplicationController < Sinatra::Base
  include Helpers
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    require 'sinatra/flash'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash, :sweep => true
  end

  get "/" do
      erb :index
  end
end