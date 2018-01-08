class CreateMusics < ActiveRecord::Migration[5.1]
  def change
    create_table :musics do |t|
      t.string :idstr
      t.string :title
      t.string :kana
      t.integer :musictype
      t.integer :order
      t.date :added_on
      t.date :updated_on
      t.integer :level_2m
      t.integer :level_2mp
      t.integer :level_4m
      t.integer :level_6m
      t.integer :level_mm
      t.integer :level_mmp

      t.timestamps
    end
    add_index :musics, :idstr, :unique=>true
  end
end
