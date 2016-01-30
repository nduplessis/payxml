require 'spec_helper'

describe PayXML::Message do
 it 'creates a valid xml string' do
   message = PayXML::Message.new( '10011013800', 'test' )
   xml_doc  = Nokogiri::XML(message.to_s)
   expect(xml_doc.xpath("//protocol").first['ver']).to eq('4.0')
   expect(xml_doc.xpath("//protocol").first['pgid']).to eq('10011013800')
   expect(xml_doc.xpath("//protocol").first['pwd']).to eq('test')
 end

 it 'parses an xml string' do
   message = PayXML::Message.new( '<protocol ver="4.0" pgid="10011013800" pwd="test">' )
   expect(message.paygate_id).to eq('10011013800')
   expect(message.paygate_id).to eq('test')
 end
end
