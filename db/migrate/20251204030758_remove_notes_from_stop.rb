class RemoveNotesFromStop < ActiveRecord::Migration[8.1]
  def change
    remove_column :stops, :notes, :string
  end
end
