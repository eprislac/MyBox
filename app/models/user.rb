class User < ActiveRecord::Base
 has_many :folders
 has_many :assets
 # this is for folders which the user has shared
 has_many :shared_folders, :dependent => :destroy
 # this is for folders that have been shared to the user by other users
 has_many :being_shared_folders, :class_name => "SharedFolder", :foreign_key => "shared_user_id", :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  after_create :check_and_assign_shared_ids_to_shared_folders
  
  # this is to  amke sure the new user, of which the email addresses already used to share folders, to have access to folders shared with that user
  def check_and_assign_shared_ids_to_shared_folders
    # First checking if the new user's email address exists in any SharedFolder records
    shared_folders_with_same_email = SharedFolder.find_all_by_shared_email(self.email)
    
    if shared_folders_with_same_email
      # Loop and update the shared user id with this new user id
      shared_folders_with_same_email.each do |shared_folder|
        shared_folder.shared_user_id = self.id
        shared_folder.save
      end
  end
  
end
