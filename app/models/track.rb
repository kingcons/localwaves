class Track < ActiveRecord::Base
  belongs_to :user
  validates :soundcloud_id, unique: true
end
