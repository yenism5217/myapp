class AddMicropostToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :micropost_id, :integer
  end

  def down
  end
end
