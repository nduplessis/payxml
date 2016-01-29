require "payxml/version"
require "payxml/result_codes"
require "payxml/credit_card_types"
require "nokogiri"

module PayXML
  # Your code goes here...
  class PayXML
    # PayXML API version number
    PAYXML_VERSION_NUMBER = '4.0'

    def initialize(paygate_id, paygate_password)
      @paygate_id = paygate_id
      @paygate_password = paygate_password
    end

    def authx_no_3d_secure
    end

    # budget_period
    def authx(
      customer_name,
      customer_reference,
      credit_card_number,
      expiry_date,
      cvv,
      amount,
      currency,
      options = { budget_period: 0, bno: '' })

      doc = Nokogiri::XML::Document.new
      root = self.message_header(doc)

      authx = Nokogiri::XML::Node.new "authx", doc
      authx['cref'] = customer_reference
      authx['cname'] = customer_name
      authx['cc'] = credit_card_number
      authx['exp'] = expiry_date
      authx['budp'] = 0.to_s
      authx['amt'] = amount
      authx['cvv'] = currency
      authx['bno'] = ''

      root << authx
      doc << root

      puts doc
    end

    protected
    def message_header(xml_doc)
      protocol_header =  Nokogiri::XML::Node.new "protocol", xml_doc
      protocol_header['ver'] = PAYXML_VERSION_NUMBER
      protocol_header['pgid'] = @paygate_id
      protocol_header['pwd'] = @paygate_password
      protocol_header
    end

    def parse_authx
    end

    def validate_response
    end

  end
end
