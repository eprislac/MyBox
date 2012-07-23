class SharedFolder < ActiveRecord::Base
  attr_accessible :folder_id, :message, :shared_email, :shared_user_id, :user_id
  # This is the owner (asset creator)
  belongs_to :user
  # this is the user to whom the owner has shared folders
  belongs_to :shared_user, :class_name => "User", :foreign_key => "shared_user_id"
  #for the folders being shared_email
  belongs_to :folder
end
