class AddPasswordDigestTeachers < ActiveRecord::Migration
    def change
      add_column :teachers, :password_digest, :string
    end
  end