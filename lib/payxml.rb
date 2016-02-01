require "payxml/version"
require "payxml/result_codes"
require "payxml/credit_card_types"
require "nokogiri"
require 'digest'

module PayXML
  class PayXML
    # PayXML API version number
    PAYXML_VERSION_NUMBER = '4.0'

    PAYXML_URL = 'https://www.paygate.co.za/payxml/process.trans'

    def initialize(paygate_id, paygate_password)
      @paygate_id = paygate_id
      @paygate_password = paygate_password
    end

    def authtx(customer_name, customer_reference, credit_card_number, expiry_date, cvv, amount, currency, options = { budget_period: 0, bno: '' })
      authtx = Auth::Request.new(@paygate_id, @paygate_password)
      authx.customer_reference = customer_reference
      authx.customer_name = customer_name
      authx.credit_card_number = credit_card_number
      # authx. = expiry_date
      # authx['budp'] = 0.to_s
      # authx['amt'] = amount
      # authx['cvv'] = currency
      # authx['bno'] = ''

      response = post_request_body(authx.xml_string)
      response_object = PayXML::Auth::Response.allocate
      response_object.parse(response)
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
