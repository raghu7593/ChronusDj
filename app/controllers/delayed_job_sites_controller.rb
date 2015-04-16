class DelayedJobSitesController < ApplicationController

  def new
    @delayed_job_site = DelayedJobSite.new
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def edit
    @delayed_job_site = DelayedJobSite.find(params[:id])
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def create
    debugger
    @delayed_job_site = DelayedJobSite.create!(delayed_job_site_params)
    redirect_to delayed_job_sites_path and return
  end

  def update
    @delayed_job_site = DelayedJobSite.find(params[:delayed_job_site][:id])
    @delayed_job_site.update_attributes!(delayed_job_site_params)
    redirect_to delayed_job_sites_path and return
  end

  def index
    @delayed_job_sites = DelayedJobSite.all
  end

  private
  def delayed_job_site_params
    params.require(:delayed_job_site).permit(:environment, :url, :user_name, :password, :active)
  end
end