class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address_line

      t.timestamps
    end
    add_index :locations, [:name, :address_line ]
  end
end
