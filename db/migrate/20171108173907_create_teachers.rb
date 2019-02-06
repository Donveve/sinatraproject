
class CreateTeachers < ActiveRecord::Migration
    def change
      create_table :teachers do |t|
        t.string :name
        t.integer :student_id
      end
    end
  end