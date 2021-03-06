class CreateDelayedJobSites < ActiveRecord::Migration
  def change
    create_table :delayed_job_sites do |t|
      t.string :environment
      t.string :url
      t.boolean :active, :default => true
      t.string :user_name
      t.string :password
      t.string :lastpass_match

      t.timestamps null: false
    end
  end
end
