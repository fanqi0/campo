class RemoveCountFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :post_count, :float
    remove_column :users, :comment_count, :float
  end
end
