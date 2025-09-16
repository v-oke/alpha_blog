class DropMigration < ActiveRecord::Migration[8.0]
  def change
    drop_table :migrations
  end
end
