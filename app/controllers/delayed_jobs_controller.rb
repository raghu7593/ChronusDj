class DelayedJobsController < ApplicationController
  require 'net/http'

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

    end
  end
end