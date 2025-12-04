class AddCompletedAtToStop < ActiveRecord::Migration[8.1]
  def change
    add_column :stops, :completed_at, :datetime
  end
end
