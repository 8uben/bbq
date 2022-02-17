class ChangeColumnPhotoOnNotNullInPhotos < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:photos, :photo, false)
  end
end
