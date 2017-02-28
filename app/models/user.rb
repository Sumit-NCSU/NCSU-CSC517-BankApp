class User < ApplicationRecord
  has_and_belongs_to_many :friends,
                          class_name: "User",
                          foreign_key: "friend1_id",
                          association_foreign_key: "friend2_id",
                          join_table: "friends"
	EMAIL_REGEX = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i
	validates :name, :presence => true
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true, :length => { :in => 6..50 }

  def self.authenticate(login_email='', login_password='')
    user = User.where(:email=>login_email).where(:password=>login_password).first
    if user
      return user
    else
      return false
    end
  end

  def self.search(search)
    if search
      self.where(["name LIKE ? or email LIKE ?","#{search}".to_i,"#{search}".to_i])
    else
      nil
    end
  end

  def self.allPlain
    User.where(:is_admin=>false)
  end

  def is_default
    id == 0
  end

end
