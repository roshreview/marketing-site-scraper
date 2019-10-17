require 'kimurai'
require 'pry'
require './url_helper'


class RoshReviewMarketingCrawler < Kimurai::Base
  @name = "roshreview_marketing_crawler"
  @driver = :mechanize
  @start_urls = ['https://www.roshreview.com']
  @config = {
    skip_request_errors: [{ error: RuntimeError, message: "404 => Net::HTTPNotFound" }]
  }
  @@marketing_url_helper = UrlHelper.new('www.roshreview.com')
  @@app_url_helper = UrlHelper.new('app.roshreview.com')

  def self.open_spider
   puts "> Starting..."
  end

  def self.close_spider
   @@marketing_url_helper.save_to_file
   @@app_url_helper.save_to_file
   binding.pry
  end

  def parse(response, url:, data: {})
   marketing_urls = @@marketing_url_helper.get_urls_from_response(response)
   @@app_url_helper.record_all_urls_in_response(response)

   marketing_urls.each do |u|
     next unless unique?(:url, u)

     request_to(:parse, url: u, data: data)
     @@marketing_url_helper.record_visited(u)
   end
  end
end

RoshReviewMarketingCrawler.crawl!
