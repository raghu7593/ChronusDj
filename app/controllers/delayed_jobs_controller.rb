class DelayedJobsController < ApplicationController
  require 'net/http'

  def index
    @delayed_jobs = DelayedJob.all
  end

  def pull_delayed_jobs
    collect_response
  end

  private
  def collect_response
    uri = URI.parse("http://walkthru.chronus.com/delayed_job/failed")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth("", "")
    response = http.request(request)
    dj_responses = Nokogiri::HTML.parse(response.body).xpath("//li[@class='job']")
    dj_responses.each do |dj_response|
      keys = dj_response.xpath(".//dt")
      values = dj_response.xpath(".//dd")
      dj_object = DelayedJob.new
      keys.zip(values).each do |key, value|
        save_data(key, value, dj_object)
      end
      dj_object.save!
    end
  end

  def save_data(key, value, dj_object)
    case key.text
    when "ID"
      dj_object.dj_id = value.xpath(".//a")[1].text
    when "Priority"
      dj_object.dj_priority = value.text.to_i
    when "Attempts"
      dj_object.dj_attempts = value.text.to_i
    when "Handler"
      dj_object.dj_handler = value.xpath(".//pre").text
    when "Last Error"
      dj_object.dj_last_error = value.xpath(".//pre")[0].text
      dj_object.dj_backtrace = value.xpath(".//pre")[1].text
    when "Run At"
      dj_object.dj_run_at = DateTime.parse(value.text)
    when "Locked At"
      dj_object.dj_locked_at = DateTime.parse(value.text)
    when "Locked By"
      dj_object.dj_locked_by = value.text
    when "Failed At"
      dj_object.dj_failed_at = DateTime.parse(value.text)
    when "Created At"
      dj_object.dj_created_at = DateTime.parse(value.text)
    end
  end
end