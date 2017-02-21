class User < ApplicationRecord

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
      self.where(["name = ? or email = ?","#{search}".to_i,"#{search}".to_i])
    else
      nil
    end
  end

end
