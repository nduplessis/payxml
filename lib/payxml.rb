require "payxml/version"
require "payxml/result_codes"
require "payxml/credit_card_types"

module PayXML
  # Your code goes here...
  class PayXML
    # PayXML API version number
    PAYXML_VERSION_NUMBER = '4.0'

    def initialize(paygate_id, paygate_password)
      @paygate_id = paygate_id
      @paygate_password = paygate_password
    end

    def process_transaction
    end

    private
    def message_header
      "<protocol ver=\"#{PAYXML_VERSION_NUMBER}\" pgid=\"#{@paygate_id}\" pwd=\"#{@paygate_password}\">"
    end

    def authx
    end

    def validate_response
    end

  end
end
