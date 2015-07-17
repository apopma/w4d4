class AddBonusToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :bonus?, :boolean
    change_column :tracks, :bonus?, :boolean, null: false
  end
end
