module PayXML
  module AuthTX

    class Request < Message
      attr_accessor :customer_name
      attr_accessor :customer_reference
      attr_accessor :budget_period
      attr_accessor :amount
      attr_accessor :currency
      attr_accessor :bno
      attr_accessor :credit_card_number
      attr_accessor :cvv
      attr_accessor :expiry_date

      def parse(xml_string)
        super(xml_string)

        doc = Nokogiri::XML(xml_string)
        authtx = doc.xpath("//authtx").first
        self.customer_reference = authtx['cref']
        self.customer_name = authtx['cname']
        self.credit_card_number = authtx['cc']
        self.expiry_date = authtx['exp']
        self.cvv = authtx['cvv']
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
