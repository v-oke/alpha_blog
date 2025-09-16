class CreateMigration < ActiveRecord::Migration[8.0]
  def change
    create_table :migrations do |t|
      t.string :name
      t.timestamps
    end
  end
end
