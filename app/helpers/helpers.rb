module Helpers

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
