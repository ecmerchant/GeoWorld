class AddFeedResultToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :new_feed_id, :string
    add_column :accounts, :new_upload, :datetime
    add_column :accounts, :del_feed_id, :string
    add_column :accounts, :del_upload, :datetime
  end
end
