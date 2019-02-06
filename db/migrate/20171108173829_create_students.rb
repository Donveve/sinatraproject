class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.integer :grade
      t.integer :lesson_id
      t.integer :subject_id
    end
  end
end