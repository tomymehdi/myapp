class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :title, :author
  end
end
