require "payxml/version"
require "payxml/result_codes"
require "payxml/credit_card_types"
require "payxml/message"
require "payxml/error"
require "payxml/auth"
require "nokogiri"
require 'digest'
require 'net/http'

module PayXML
  class PayXML
    # PayXML API version number
    PAYXML_VERSION_NUMBER = '4.0'

    PAYXML_URL = 'https://www.paygate.co.za/payxml/process.trans'

    def initialize(paygate_id, paygate_password)
      @paygate_id = paygate_id
      @paygate_password = paygate_password
    end

    def purchase(options = {})
      authtx = Auth::Request.new(@paygate_id, @paygate_password)
      authtx.customer_reference = options[:customer_reference]
      authtx.customer_name = options[:customer_name]
      authtx.credit_card_number = options[:credit_card_number]
      authtx.expiry_date = options[:expiry_date]
      authtx.currency = options[:currency]
      authtx.amount = options[:amount]
      authtx.cvv = options[:cvv]

      authtx.customer_ip_address = options[:customer_ip_address]
      authtx.notify_callback_url = options[:notify_callback_url]
      authtx.response_url = options[:response_url]

      response = post_request_body(authtx.xml_string)

      if !(response.body =~ /errorrx/i).nil?
        response_object = Error.allocate
        response_object.parse(response.body)
      else
        response_object = Auth::Response.allocate
        response_object.parse(response.body)
      end

      response_object
    end

    def self.checksum(values=[])
      md5 = Digest::MD5.new
      md5 << values.map { |i| i.to_s }.join("|")
      md5.hexdigest
    end

    protected
    def post_request_body(xml_body)
      uri = URI.parse PAYXML_URL
      request = Net::HTTP::Post.new uri.path
      request.body = xml_body
      request.content_type = 'text/xml'
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request(request)

      response
    end

    def validate_response
    end

  end
end
