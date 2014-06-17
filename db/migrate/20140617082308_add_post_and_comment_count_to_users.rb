class AddPostAndCommentCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post_count, :float
    add_column :users, :comment_count, :float
  end
end
