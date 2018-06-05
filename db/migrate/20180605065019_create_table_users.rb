class CreateTableUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :table_users do |t|
      t.string :email, null: false
      t.timestamps
    end
  end
end
