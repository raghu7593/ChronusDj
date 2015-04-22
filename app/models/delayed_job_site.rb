class DelayedJobSite < ActiveRecord::Base
  require 'net/http'
  require 'lastpass.rb'

  has_many :delayed_jobs

  DEFAULT_USER_NAME = "chronusmentor"

  def self.sync_all_active_sites
    DelayedJobSite.where(active: true).each do |delayed_job_site|
      delayed_job_site.sync_active_delayed_job_site
    end
  end

  def sync_active_delayed_job_site
    return unless self.active?
    uri = URI::join(self.url, "delayed_job/failed")
    credentials = get_credentials
    nokogiri_response = get_response(uri, credentials)
    collect_delayed_jobs_recursively(nokogiri_response, credentials)
  end

  private
  def get_credentials(options = {})
    if options[:use_lastpass]
      vault = LastPass::Vault.open_remote options[:lp_user_name], options[:lp_password]
      lastpass_account = vault.accounts.detect{|account| account.name.match(self.lastpass_match)}
      if lastpass_account
        return {
          :username => lastpass_account.user_name.presence || DEFAULT_USER_NAME,
          :password => lastpass_account.password
        }
      end
    else
      return {
        :username => self.user_name.presence || DEFAULT_USER_NAME,
        :password => self.password
      }
    end
  end

  def collect_delayed_jobs_recursively(nokogiri_response, credentials)
    dj_responses = nokogiri_response.xpath("//li[@class='job']")
    dj_responses.each do |dj_response|
      keys = dj_response.xpath(".//dt")
      values = dj_response.xpath(".//dd")
      dj_object = self.delayed_jobs.build
      keys.zip(values).each do |key, value|
        save_data(key, value, dj_object)
      end
      set_function_name(dj_object)
      dj_object.save!
    end
    return if nokogiri_response.xpath(".//a[@class='more']").empty?
    next_url = nokogiri_response.xpath(".//a[@class='more']/@href").text
    next_uri = URI::join(self.url, next_url)
    nokogiri_response = get_response(next_uri, credentials)
    collect_delayed_jobs_recursively(nokogiri_response, credentials)
  end

  def get_response(uri, credentials)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(credentials[:username], credentials[:password])
    response = http.request(request)
    raise response.code unless response.code.to_i == 200
    nokogiri_response = Nokogiri::HTML.parse(response.body)
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

  def set_function_name(dj_object)
    return unless dj_object.dj_handler
    dj_object.dj_function_name = dj_object.dj_handler.match(/method_name: :(.+?)\n/i).captures.first
  end
end
