class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :user
      t.string :list_type
      t.integer :list_num
      t.text :body

      t.timestamps
    end
  end
end
