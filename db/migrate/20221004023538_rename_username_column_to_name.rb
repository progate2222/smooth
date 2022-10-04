class RenameUsernameColumnToName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :user_name, :name
  end
end
