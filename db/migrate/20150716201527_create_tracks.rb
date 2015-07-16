class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.integer :album_id, null: false
      t.integer :track_number, null: false
      t.text :lyrics
      t.timestamps null: false
    end

    add_index :tracks, [:album_id, :track_number], unique: true
  end
end
