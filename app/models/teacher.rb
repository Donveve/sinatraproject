class Teacher < ActiveRecord::Base
    validates :username, uniqueness: true
  
  
    has_secure_password
  
    has_many :students
    has_many :subjects
    has_many :lessons
  end