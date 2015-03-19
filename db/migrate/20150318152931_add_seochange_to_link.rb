class AddSeochangeToLink < ActiveRecord::Migration
  def change
    add_column :links, :seo_change, :string
  end
end
