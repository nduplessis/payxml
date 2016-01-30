module PayXML
  module AuthTX

    class Request < PayXML::Message
      attr_accessor :customer_name
      attr_accessor :customer_reference
      attr_accessor :budget_period
      attr_accessor :expiry_date
      attr_accessor :amount
      attr_accessor :currency
      attr_accessor :bno
      attr_accessor :credit_card_number

      def to_s
        doc = Nokogiri::XML::Document.new
        # root = PayXML::Protocol.new
        #
        # authtx = Nokogiri::XML::Node.new "authtx", doc
        # authtx['cref'] = customer_reference
        # authtx['cname'] = customer_name
        # authtx['cc'] = credit_card_number
        # authtx['exp'] = expiry_date
        # authtx['budp'] = 0.to_s
        # authtx['amt'] = amount
        # authtx['cvv'] = currency
        # authtx['bno'] = ''
        #
        # root << authx
        # doc << root

        doc.to_s
      end
    end

    class Response

      def initialize(xml_string)
        @xml_string = xml_string
      end

      def to_s
        @xml_string
      end

    end

  end
end
