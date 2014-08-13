class AddImageToFriendSites < ActiveRecord::Migration
  def change
    add_column :friend_sites, :image, :string
  end
end
