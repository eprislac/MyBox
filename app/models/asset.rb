class Asset < ActiveRecord::Base
  attr_accessible :user_id, :uploaded_file, :folder_id
  belongs_to :user
  belongs_to :folder
  #set up "uploaded_file" field as attached_file (using Paperclip)  
  has_attached_file :uploaded_file,
  		:url => "Assets/get/:id",
  		:path => ":rails_root/assets/:id/:basename.:extension"
  validates_attachment_size :uploaded_file, :less_than => 100.megabytes
  validates_attachment_presence :uploaded_file
  
  def file_name
    uploaded_file_file_name
  end
  
  def file_size
    uploaded_file_file_size
  end
  
end
