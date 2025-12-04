class RenameOldFieldsToNewFieldsInManifest < ActiveRecord::Migration[8.1]
  def change
    rename_column :manifests, :start_at, :started_at
    rename_column :manifests, :end_at, :ended_at
  end
end
