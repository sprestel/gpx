class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.datetime :time
      t.decimal :latitude, :precision => 20, :scale => 10
      t.decimal :longitude, :precision => 20, :scale => 10
      t.decimal :elevation, :precision => 20, :scale => 10
      t.decimal :distance, :precision => 20, :scale => 10
      t.decimal :duration, :precision => 20, :scale => 10
      t.decimal :active_duration, :precision => 20, :scale => 10
      t.decimal :pace, :precision => 20, :scale => 10
      t.decimal :speed, :precision => 20, :scale => 10
      t.integer :heart_rate
      t.integer :cadence
      t.references :ride
      t.timestamps
    end
  end
end
