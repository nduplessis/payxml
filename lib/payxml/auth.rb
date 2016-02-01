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
      attr_reader :customer_reference
      attr_reader :transaction_id
      attr_reader :card_type
      attr_reader :bno
      attr_reader :result_description
      attr_reader :result_code
      attr_reader :transaction_status_description
      attr_reader :transaction_status
      attr_reader :authorisation_code
      attr_reader :risk
      attr_reader :secure_redirect_url
      attr_reader :secure_checksum

      def requires_secure_redirect?
        !self.secure_redirect_url.nil?
      end

      def parse(xml_string)
        super(xml_string)

        doc = Nokogiri::XML(xml_string)
        authrx = doc.xpath("//authrx").first
        securerx = doc.xpath("//securerx").first
        if !authrx.nil?
          @customer_reference = authrx['cref'] unless authrx['cref'].nil?
          @transaction_id = authrx['tid'] unless authrx['tid'].nil?
          @card_type = authrx['ctype'] unless authrx['ctype'].nil?
          @transaction_status = authrx['stat'] unless authrx['stat'].nil?
          @transaction_status_description = authrx['sdesc'] unless authrx['sdesc'].nil?
          @bno = authrx['bno'] unless authrx['bno'].nil?
          @result_code = authrx['res'] unless authrx['res'].nil?
          @result_description = authrx['rdesc'] unless authrx['rdesc'].nil?
          @authorisation_code = authrx['auth'] unless authrx['auth'].nil?
          @risk = authrx['risk'] unless authrx['risk'].nil?
        elsif !securerx.nil?
          @customer_reference = securerx['cref'] unless securerx['cref'].nil?
          @transaction_id = securerx['tid'] unless securerx['tid'].nil?
          @secure_redirect_url = securerx['url'] unless securerx['url'].nil?
          @secure_checksum = securerx['chk'] unless securerx['chk'].nil?
        end
      end
    end

  end
end
