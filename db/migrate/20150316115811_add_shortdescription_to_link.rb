class AddShortdescriptionToLink < ActiveRecord::Migration
  def change
    add_column :links, :short_description, :string
  end
end
