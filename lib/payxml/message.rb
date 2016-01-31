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
      doc = Nokogiri::XML(xml_string)
      protocol = doc.xpath("//protocol").first
      message = self.new(protocol['pgid'], protocol['pwd'])
    end

    def to_s
      xml_doc.to_s
    end

    protected

    def xml_doc
      doc = Nokogiri::XML::Document.new

      protocol = Nokogiri::XML::Node.new "protocol", doc
      protocol['ver'] = PAYXML_VERSION_NUMBER
      protocol['pgid'] = self.paygate_id
      protocol['pwd'] = self.paygate_password

      doc << protocol

      doc
    end
  end

end
