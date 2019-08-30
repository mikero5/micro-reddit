class RemoveFkUserFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :fk_user, :integer
  end
end
