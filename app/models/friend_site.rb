class FriendSite < ActiveRecord::Base

  mount_uploader :adfile, AdfileUploader

  # has_one :adfile, dependent: :destroy
end
