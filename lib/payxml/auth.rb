module PayXML
  module Auth

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
        self.customer_reference = authtx['cref'] unless authtx['cref'].nil?
        # self.customer_name = authtx['cname']
        # self.credit_card_number = authtx['cc']
        # self.expiry_date = authtx['exp']
        # self.cvv = authtx['cvv']
        # self.budget_period = authtx['budp']
        # self.currency = authtx['cur']
      end

      protected
      def xml_doc
        doc = super

        protocol = doc.xpath("//protocol").first
        authtx = Nokogiri::XML::Node.new "authtx", doc
        authtx['cref'] = self.customer_reference
        authtx['cname'] = self.customer_name
        authtx['cc'] = self.credit_card_number
        protocol.add_child(authtx)

        doc
      end
    end

    class Response < Message
      attr_accessor :customer_reference
      attr_accessor :transaction_id
      attr_accessor :card_type
      attr_accessor :bno
      attr_accessor :result_description
      attr_accessor :result_code
      attr_accessor :transaction_status_description
      attr_accessor :transaction_status
      attr_accessor :authorisation_code
      attr_accessor :risk

      def parse(xml_string)
        super(xml_string)

        doc = Nokogiri::XML(xml_string)
        authtx = doc.xpath("//authrx").first
        self.customer_reference = authtx['cref'] unless authtx['cref'].nil?
        self.transaction_id = authtx['tid'] unless authtx['tid'].nil?
        self.card_type = authtx['ctype'] unless authtx['ctype'].nil?
        self.transaction_status = authtx['stat'] unless authtx['stat'].nil?
        self.transaction_status_description = authtx['sdesc'] unless authtx['sdesc'].nil?
        self.bno = authtx['bno'] unless authtx['bno'].nil?
        self.result_code = authtx['res'] unless authtx['res'].nil?
        self.result_description = authtx['rdesc'] unless authtx['rdesc'].nil?
        self.authorisation_code = authtx['auth'] unless authtx['auth'].nil?
        self.risk = authtx['risk'] unless authtx['risk'].nil?
      end
    end

  end
end
