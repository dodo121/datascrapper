class AddQueryidToLink < ActiveRecord::Migration
  def change
    add_column :links, :query_id, :integer
  end
end
