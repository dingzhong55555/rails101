class CreateGroupRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :group_relationships do |t|
      t.string :group_id
      t.string :integer
      t.string :user_id
      t.string :integer

      t.timestamps
    end
  end
end
