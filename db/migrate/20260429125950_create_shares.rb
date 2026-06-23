class CreateShares < ActiveRecord::Migration[8.1]
  def change
    create_table :shares do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :permission

      t.timestamps
    end
    add_index :shares, [ :entry_id, :user_id ], unique: true
  end
end
