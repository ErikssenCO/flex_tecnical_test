class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions do |t|
      t.references :employee, null: false, foreign_key: true, index: true
      t.string :session_token

      t.timestamps
    end
  end
end
 