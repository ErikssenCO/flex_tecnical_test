class CreateDrivers < ActiveRecord::Migration[8.1]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :fiscal_number
      t.string :phone
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :drivers, [:fiscal_number, :phone], unique: true
    add_index :drivers, :status
  end
end
