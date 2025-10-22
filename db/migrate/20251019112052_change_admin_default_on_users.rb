# db/migrate/xxxxxx_change_admin_default_on_users.rb
class ChangeAdminDefaultOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :admin, false
  end
end