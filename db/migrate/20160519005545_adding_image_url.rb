class AddingImageUrl < ActiveRecord::Migration
  def change
    add_column :users, :image_url, :string
  end
end
