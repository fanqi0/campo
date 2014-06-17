class RemoveHotFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :hot, :float
  end
end
