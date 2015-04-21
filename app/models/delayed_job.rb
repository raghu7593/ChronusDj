class DelayedJob < ActiveRecord::Base
  belongs_to :delayed_job_site
end
