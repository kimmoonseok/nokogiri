class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.text :name
      t.string :rank
      t.string :imge
      t.timestamps null: false
    end
  end
end
