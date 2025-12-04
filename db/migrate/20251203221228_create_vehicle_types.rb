class CreateVehicleTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicle_types do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end

    add_index :vehicle_types, :name, unique: true
    add_index :vehicle_types, :active
  end
end
