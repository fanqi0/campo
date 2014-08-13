class CreateHotThemes < ActiveRecord::Migration
  def change
    create_table :hot_themes do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
