class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.integer :status, default: 0, null: false
      t.references :vehicle_type, null: false, foreign_key: true, index: true

      t.timestamps
    end
    add_index :vehicles, :plate, unique: true
    add_index :vehicles, :status
  end
end
