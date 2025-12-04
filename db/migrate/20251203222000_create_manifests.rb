class CreateManifests < ActiveRecord::Migration[8.1]
  def change
    create_table :manifests do |t|
      t.datetime :scheduled_start_at
      t.datetime :scheduled_end_at
      t.datetime :start_at
      t.datetime :end_at
      t.integer :status, default: 0, null: false
      t.references :driver, null: false, foreign_key: true, index: true
      t.references :vehicle, null: false, foreign_key: true, index: true
      t.references :created_by, null: false, foreign_key: { to_table: :employees }, index: true
      t.references :original_location, null: false, foreign_key: { to_table: :locations }, index: true
      t.references :destination_location, null: false, foreign_key: { to_table: :locations }, index: true

      t.timestamps
    end

    add_index :manifests, [:status, :scheduled_start_at, :start_at, :end_at]
  end
end
