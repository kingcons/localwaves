class Track < ActiveRecord::Base
  belongs_to :user
  validates :soundcloud_id, uniqueness: true
end
