class CreateSelectedApplications < ActiveRecord::Migration
  def change
    create_table :selected_applications do |t|
      t.integer :tender_id, :null => false
      t.integer :application_id, :null => false

      t.timestamps
    end
  end
end
