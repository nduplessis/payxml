require "payxml/version"
require "payxml/result_codes"
require "payxml/credit_card_types"
require "payxml/message"
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

    def authorise(customer_name, customer_reference, credit_card_number, expiry_date, cvv, amount, currency, options = { budget_period: 0, bno: '' })
      authtx = Auth::Request.new(@paygate_id, @paygate_password)
      authtx.customer_reference = customer_reference
      authtx.customer_name = customer_name
      authtx.credit_card_number = credit_card_number
      authtx.expiry_date = expiry_date
      authtx.currency = currency
      authtx.amount = amount
      authtx.cvv = cvv

      puts "#{expiry_date} : #{authtx.expiry_date}"
      puts authtx.xml_string

      response = post_request_body(authtx.xml_string)
      response_object = Auth::Response.allocate
      response_object.parse(response.body)

      puts response.body

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
