class RemoveCityIdFromLocations < ActiveRecord::Migration[8.1]
  def change
    remove_reference :locations, :city, null: false, foreign_key: true
  end
end
