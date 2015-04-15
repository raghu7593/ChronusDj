class CreateDelayedJobs < ActiveRecord::Migration
  def change
    create_table :delayed_jobs do |t|
      t.integer :dj_id
      t.string :dj_function_name
      t.integer :dj_priority
      t.integer :dj_attempts
      t.text :dj_handler
      t.string :dj_last_error
      t.text :dj_backtrace
      t.timestamp :dj_run_at
      t.timestamp :dj_locked_at
      t.string :dj_locked_by
      t.timestamp :dj_failed_at
      t.timestamp :dj_created_at

      t.timestamps
    end
  end
end
