class AddListNumToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :list_num, :integer
    add_column :accounts, :list_type, :string
  end
end
