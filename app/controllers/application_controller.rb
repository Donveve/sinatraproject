require './config/environment'


class ApplicationController < Sinatra::Base
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

  helpers do
    def current_student
        @current_student ||= Student.find_by(id: session[:student_id])
    end

    def current_teacher #=> Teacher Instance || nil
        @current_teacher ||= Teacher.find_by(id: session[:teacher_id])
    end

    def is_teacher_logged_in?
        !!current_teacher
    end

    def is_student_logged_in?
        !!current_student
    end
  end
end
