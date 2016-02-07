module PayXML
  class Error < Message
    attr_reader :code
    attr_reader :description

    def parse(xml_string)
      super(xml_string)

      doc = Nokogiri::XML(xml_string)
      errorrx = doc.xpath("//errorrx").first

      @code = errorrx['ecode']
      @description = errorrx['edesc']
    end

    protected
    def xml_doc
      doc = super

      protocol = doc.xpath("//protocol").first
      errorrx = Nokogiri::XML::Node.new "errorrx", doc
      protocol.add_child(errorrx)

      doc
    end
  end
end
