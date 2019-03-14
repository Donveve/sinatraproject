class Student < ActiveRecord::Base
    has_secure_password
    validates :username, uniqueness: true

  has_many :lessons
  has_many :subjects
  belongs_to :teacher
end