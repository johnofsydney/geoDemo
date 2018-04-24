class AddLatitudeAndLongitudeToStation < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :latitude, :float
    add_column :stations, :longitude, :float
  end
end
