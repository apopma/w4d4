class AddAlbumTypeToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :live?, :boolean
    change_column :albums, :live?, :boolean, null: false
  end
end
