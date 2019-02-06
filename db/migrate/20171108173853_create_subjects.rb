class CreateSubjects < ActiveRecord::Migration
    def change
      create_table :subjects do |t|
        t.string :name
        t.integer :student_id
      end
    end
  end