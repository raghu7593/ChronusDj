class DelayedJobsController < ApplicationController

  def index
    @delayed_jobs = DelayedJob.all
  end

  def show
    @delayed_job = DelayedJob.find(params[:id])
    respond_to do |format|
      format.js {render layout: false}
    end
  end
end