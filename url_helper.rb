require 'uri'
require 'set'
require 'date'

class UrlHelper
  attr_reader :all_urls, :visited_urls

  def initialize(host)
    @host = host
    @all_urls = Set[]
    @visited_urls = Set[]
  end

  def get_urls_from_response(response)
    all_urls = get_all_anchor_urls(response)
    record_urls(all_urls)
    all_urls
  end

  def record_all_urls_in_response(response)
    all_urls = get_all_anchor_urls(response)
    record_urls(all_urls)
  end

  def record_visited(url)
    @visited_urls.add(url)
  end

  def save_to_file
    save_all_urls
    save_visited_urls
  end

  private
  def is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def contains_host?(url)
    url.starts_with?("http://#{@host}", "https://#{@host}")
  end

  def record_urls(urls)
    @all_urls.merge(urls.to_set)
  end

  def get_all_anchor_urls(response)
    response.css('a').reduce([]) do |hrefs, elem|
      href = elem['href']
      next hrefs.push(href) if is_url?(href) and contains_host?(href)

      hrefs
    end
  end

  def save_all_urls
    File.open("#{@host}_all_urls_#{DateTime.now.to_s}", 'w') do |file|
      @all_urls.each do |url|
        file.puts(url)
      end
    end
  end

  def save_visited_urls
    File.open("#{@host}_visited_urls_#{DateTime.now.to_s}", 'w') do |file|
      @visited_urls.each do |url|
        file.puts(url)
      end
    end
  end
end
