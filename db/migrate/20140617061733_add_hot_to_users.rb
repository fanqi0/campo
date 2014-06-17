class AddHotToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hot, :float, default: 0.0
  end
end
