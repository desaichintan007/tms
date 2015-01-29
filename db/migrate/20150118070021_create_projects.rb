class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :budget
      t.date :start_date
      t.date :end_date
      t.text :associated_people
      t.text :user_id

      t.timestamps
    end
  end
end
