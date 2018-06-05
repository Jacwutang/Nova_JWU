class CreateTableUserAuthorizationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :table_user_authorization_tokens do |t|
    t.string :token, null:false
    t.integer :user_id, null:false
    t.timestamps
    end

    add_index :table_user_authorization_tokens, :user_id, unique: true
  end
end
