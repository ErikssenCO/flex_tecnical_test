class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :fiscal_number
      t.string :email
      t.string :password_digest

      t.timestamps

      add_index(:employees, [ :fiscal_number, :email ], unique: true)
    end
  end
end
