class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :profile_pic

      t.timestamps null: false
    end
  end
end
