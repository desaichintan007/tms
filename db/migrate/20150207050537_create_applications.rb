class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.text :cover
      t.text :proposal
      t.string :estimated_budget
      t.string :estimated_time
      t.string :status, :default => Application::STATUS[0]
      t.integer :user_id
      t.integer :tender_id

      t.timestamps
    end
  end
end
