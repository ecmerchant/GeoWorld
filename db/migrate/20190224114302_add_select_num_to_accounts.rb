class AddSelectNumToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :select_new, :integer, default: 1
    add_column :accounts, :select_del, :integer, default: 1
  end
end
