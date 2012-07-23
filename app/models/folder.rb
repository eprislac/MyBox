class Folder < ActiveRecord::Base
  acts_as_tree
  attr_accessible :name, :parent_id, :user_id
  belongs_to :user
  has_many :assets, :dependent => :destroy
  has_many :shared_folders, :dependent => :destroy
  
  # a method to determine wheter a folder has been shared or not
  def
    !self.shared_assets.empty?
  end
end
