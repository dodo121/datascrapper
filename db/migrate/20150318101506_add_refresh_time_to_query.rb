class AddRefreshTimeToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :refresh_time, :integer
  end
end
