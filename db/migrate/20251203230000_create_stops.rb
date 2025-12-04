class CreateStops < ActiveRecord::Migration[8.1]
  def change
    create_table :stops do |t|
      t.integer :position
      t.integer :status, default: 0, null: false
      t.complete_at :datetime
      t.references :location, null: false, foreign_key: true, index: true
      t.references :manifest, null: false, foreign_key: true, index: true

      t.timestamps
    end
    add_index :stops, [:manifest_id, :position, :status]
  end
end
