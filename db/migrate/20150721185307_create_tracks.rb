class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :user_id
      t.integer :soundcloud_id
      t.string :title
      t.text :description
      t.string :genre
      t.string :license
      t.string :permalink_url
      t.string :artwork_url
      t.string :waveform_url
      t.string :stream_url
      t.string :purchase_url

      t.timestamps null: false
    end
  end
end
