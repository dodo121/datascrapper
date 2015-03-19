class AddLinkToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :link_id, :integer
  end
end
