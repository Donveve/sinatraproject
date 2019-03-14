class StudentsController < ApplicationController

  get '/students/new' do
    if session[:student_id]
      session.clear
    end
      erb :'students/create_student'
  end



  post '/students/new' do
    student = Student.new(params[:student])
    if student.save
      session[:student_id] = student.id
      flash[:notice] = "Successfully signed up."
      redirect '/students/show'
    else
      flash[:warning] = student.errors.full_messages.to_sentence
      erb :'students/create_student'
    end
  end

  get '/students/show' do
    if is_student_logged_in?
      @current_time = Time.now
      erb :'/students/show'
    else
      flash[:warning] = "You need to log in to view this page"
      erb :index
    end
  end

  get '/students/login' do
    if session
      session.clear
    end
      erb :'/students/login'
  end

  post '/students/login' do
    student = Student.find_by(username: params[:student][:username])
    if student && student.authenticate(params[:student][:password])
      session[:student_id] = student.id
      flash[:success] = "You have successfully logged in"
      redirect '/students/show'
    else
      flash[:warning] = "That log in wasn't quite right. Please try again."
      erb :'/students/login'
    end
  end

  get '/students/:id/edit' do
    if is_student_logged_in?
      @lessons = Lesson.all
      @subjects = Subject.all
      @current_time = Time.now
      erb :'/students/edit_student'
    else
      flash[:warning] = "You need to log in to view this page"
      redirect "/students/login"
    end
  end

  patch '/students/:id/edit' do
    if is_student_logged_in?
      current_student.lesson_ids = params[:lesson_ids]
      current_student.subject_ids = params[:subject_ids]
      if current_student.save
        redirect to "/students/show"
      else
        flash[:warning] = current_student.errors.full_messages.to_sentence
        @lessons = Lesson.all
        @subjects = Subject.all
        @current_time = Time.now
        erb :'students/edit_student'
      end
    else
      flash[:warning] = "You need to log in to view this page"
      redirect "/students/login"
    end
  end

  get '/students/:id/delete' do
    if is_student_logged_in?
      if session[:student_id] == params[:id].to_i
        erb :'/students/delete'
      end
    else
      erb :index
    end
  end

  delete '/students/:id/delete' do
    if is_student_logged_in? && session[:student_id] == params[:id].to_i
        student = current_student
        student.destroy
        session.clear
        redirect '/'
    else
      flash[:warning] = "You need to log in to view this page"
      redirect "/students/login"
    end
  end

  get '/students/logout' do
    if is_student_logged_in?
      session.clear
      redirect '/'
    else
      flash[:warning] = "You need to log in to view this page"
      redirect "/students/login"
    end
  end
end
