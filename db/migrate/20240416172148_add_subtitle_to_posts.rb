class AddSubtitleToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :subtitle, :string
  end
end
