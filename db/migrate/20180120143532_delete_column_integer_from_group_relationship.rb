class DeleteColumnIntegerFromGroupRelationship < ActiveRecord::Migration[5.0]
  def change
    remove_column :group_relationships, :integer, :string
  end
end
