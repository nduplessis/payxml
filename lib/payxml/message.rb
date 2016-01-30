module PayXML

  class Message
    attr_accessor :paygate_id
    attr_accessor :paygate_password

    PAYXML_VERSION_NUMBER = '4.0'

    def initialize( paygate_id, paygate_password )
      self.paygate_id = paygate_id
      self.paygate_password = paygate_password
    end

    def self.parse( xml_string )
    end

    def to_s
      doc = Nokogiri::XML::Document.new

      protocol = Nokogiri::XML::Node.new "protocol", doc
      protocol['ver'] = PAYXML_VERSION_NUMBER
      protocol['pgid'] = self.paygate_id
      protocol['pwd'] = self.paygate_password

      doc << protocol
      doc.to_s
    end
  end

end
