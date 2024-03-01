require 'selenium-webdriver'
require 'nokogiri'

class ScrapingController < ApplicationController

  before_action :permit_params, only: [:fetch_data]

  REQUIRED_FIELDS = [:price, :rating_count, :rating_value]

  def fetch_data

    if missing_required_fields?
      render json: { error: "Required fields are missing" }, status: :bad_request
      return
    end

    url = @permitted_params[:url]
    fields = @permitted_params[:fields]
    data = {}

    begin
      options = Selenium::WebDriver::Chrome::Options.new

      # Specify the path to ChromeDriver executable
      chromedriver_path = File.join(Rails.root, '/chromedriver', 'chromedriver')
      Selenium::WebDriver::Chrome::Service.driver_path = chromedriver_path

      driver = Selenium::WebDriver.for :chrome, options: options
      driver.get(url)

      # Get the html from the webpage
      doc = Nokogiri::HTML(driver.page_source)

      price = doc.css(fields[:price]).map(&:text).first
      rating_count = doc.css(fields[:rating_count]).map(&:text).first
      rating_value = doc.css(fields[:rating_value]).map(&:text).first

      data = { price: price, rating_value: rating_value, rating_count: rating_count }

      unless fields[:meta].nil?
        meta = {}

        fields[:meta].each do |name|
          meta[name] = doc.at_css("meta[name='#{name}']")&.attr('content')
        end

        data[:meta] = meta      
      end

      render json: data

    rescue StandardError => e
      render json: { error: e.message }, status: :bad_request
    ensure
      driver.quit if driver
    end
  end

  private

  def permit_params
    @permitted_params = params.permit(:url, fields: [:price, :rating_count, :rating_value, meta: []])
  end

  def missing_required_fields?
    fields = @permitted_params[:fields]

    @permitted_params[:url].nil? || REQUIRED_FIELDS.any? { |field| fields[field].nil? }
  end
end
