class ChangeDescriptionToLongtext < ActiveRecord::Migration
  def self.up
    remove_column :fliers, :description
    add_column :fliers, :description, :text
  end

  def self.down
  end
end
