class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :user
      t.time :set_time
      t.string :schedule_type
      t.string :list_type
      t.integer :schedule_num, default: 1

      t.timestamps
    end
  end
end
