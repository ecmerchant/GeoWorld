class AddListNumToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :list_num, :integer, default: 1
  end
end
