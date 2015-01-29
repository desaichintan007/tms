class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :notice_duration
      t.string :minimum_budget
      t.integer :user_id

      t.timestamps
    end
  end
end
