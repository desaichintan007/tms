class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message
      t.string :intended_for
      t.integer :user_id
      t.string :url

      t.timestamps
    end
  end
end
