class ChangeColumnOfRelationships < ActiveRecord::Migration[5.0]
  def change
    change_column :group_relationships, :user_id, :integer
    change_column :group_relationships, :group_id, :integer
  end
end
