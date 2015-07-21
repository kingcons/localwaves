class AddSoundcloudIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :soundcloud_id, :integer
  end
end
