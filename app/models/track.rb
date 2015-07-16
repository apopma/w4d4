class Track < ActiveRecord::Base
  validates :title, :album_id, :track_number, presence: true
  validates :track_number, uniqueness: { scope: [:album_id, :track_number] }

  belongs_to :album
  belongs_to :band, through: :album
end
