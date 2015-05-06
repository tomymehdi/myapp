class DeleteModelTest < ActiveRecord::Migration
  def change
    drop_table :model_tests
  end
end
