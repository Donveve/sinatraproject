class TeachersController <  ApplicationController
    include Helpers
  
    get '/teachers/new' do
      if session[:teacher_id]
        session.clear
      end
        erb :'teachers/create_teacher'
    end
  
    get '/teachers/login' do
      if session[:teacher_id]
        session.clear
      end
        erb :'/teachers/login'
    end
  
    post '/teachers/login' do
      teacher = Teacher.find_by(username: params[:teacher][:username])
      if teacher && teacher.authenticate(params[:teacher][:password])
        session[:teacher_id] = teacher.id
        @time = Time.now
        erb :'/teachers/show'
      else
        flash[:warning] = "That log in wasn't quite right. Please try again."
        erb :'/teachers/login'
      end
    end
  
    post '/teachers/new' do
      teacher = Teacher.new(params[:teacher])
      if teacher.save
        session[:teacher_id] = teacher.id
        flash[:success] = "Successfully signed up!"
        redirect '/teachers/show'
      else
        flash[:warning] = teacher.errors.full_messages.to_sentence
        erb :'teachers/create_teacher'
      end
    end
  
    get '/teachers/show' do
      teacher = current_teacher
      if teacher != nil
          @time = Time.now
          erb :'/teachers/show'
      else
        flash[:warning] = "You need to log in to view this page"
        erb :index
      end
    end
  
    get '/teachers/edit_assignments' do
      if is_teacher_logged_in?
        erb:'/teachers/edit_assignments'
      else
        flash[:warning] = "You need to log in to view this page"
        redirect "/teachers/login"
      end
    end
  
    patch '/teachers/edit_assignments' do
      if  is_teacher_logged_in?
        params[:new_subject].each do |subject|
          if !subject.empty?
              Subject.create(name: subject )
          end
        end
  
        params[:new_lesson].each do |lesson|
          if !lesson.empty?
              Lesson.create(name: lesson)
          end
        end
  
        if params[:subjects]
          params[:subjects].each do |subject|
            Subject.find_by(name: subject).destroy
          end
        end
  
        if params[:lessons]
          params[:lessons].each do |lesson|
            Lesson.find_by(name: lesson).destroy
          end
        end
        redirect '/teachers/display_assignments'
      else
        flash[:warning] = "You need to log in to view this page"
        redirect "/teachers/login"
      end
    end
  
    get '/teachers/display_assignments' do
      if  is_teacher_logged_in?
        erb :'/teachers/display_assignments'
      else
        flash[:warning] = "You need to log in to view this page"
        redirect "/teachers/login"
      end
    end
  
    get '/teachers/:id/edit' do
      if  is_teacher_logged_in?
        teacher = current_teacher
        erb :'/teachers/edit_teacher'
      else
        flash[:warning] = "You need to log in to view this page"
        redirect "/teachers/login"
      end
    end
  
    patch '/teachers/:id/edit' do
      if  is_teacher_logged_in?
        teacher = current_teacher
        teacher.students = []
        if params[:students]
          params[:students].each do |student_name|
            teacher.students << Student.find_by(name: student_name)
          end
        end
  
        if params[:students_new]
          params[:students_new].each do |student_name|
            teacher.students << Student.find_by(name: student_name)
          end
        end
        @time = Time.now
        erb :'/teachers/show'
      else
        flash[:warning] = "You need to log in to view this page"
        redirect "/teachers/login"
      end
    end
  
    get '/teachers/:id/show_student' do
      if  is_teacher_logged_in?
        @student = Student.find_by(id: params[:id])
        @time = Time.now
        erb :'/teachers/show_student'
      else
        flash[:warning] = "You need to log in to view this page"
        redirect "/teachers/login"
      end
    end
  
    get '/teachers/:id/delete' do
      if  is_teacher_logged_in?
        if session[:teacher_id] == params[:id].to_i
        erb :'/teachers/delete'
        end
      else
        erb :index
      end
    end
  
    delete '/teachers/:id/delete' do
      if is_teacher_logged_in?
        if session[:teacher_id] == params[:id].to_i
          teacher = current_teacher
          teacher.destroy
          session.clear
        end
          redirect '/'
      else
        flash[:warning] = "You need to log in to view this page"
        redirect "/teachers/login"
      end
    end
  
    get '/teachers/logout' do
      if is_teacher_logged_in?
        session.clear
        redirect '/'
      else
        flash[:warning] = "You need to log in to view this page"
        redirect "/teachers/login"
      end
    end
  
  end