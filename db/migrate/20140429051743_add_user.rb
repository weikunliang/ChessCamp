class AddUser < ActiveRecord::Migration
  def up
    admin = User.new
    admin.username = "profh"
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.role = "admin"
    admin.save!
  end

  def down
    admin = User.find_by_username "profh"
    User.delete admin
  end
end
