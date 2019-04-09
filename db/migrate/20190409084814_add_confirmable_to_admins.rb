# frozen_string_literal: true

class AddConfirmableToAdmins < ActiveRecord::Migration[5.2]
  def up
    add_column :admins, :confirmation_token, :string
    add_column :admins, :confirmed_at, :datetime
    add_column :admins, :confirmation_sent_at, :datetime
    # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :admins, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    Admin.update_all confirmed_at: Time.now.getlocal
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_columns :admins, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :users, :unconfirmed_email # Only if using reconfirmable
  end
end
