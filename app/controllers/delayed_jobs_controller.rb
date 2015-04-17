class DelayedJobsController < ApplicationController

  def index
    @delayed_jobs = DelayedJob.all
  end
end