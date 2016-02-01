require 'spec_helper'

describe PayXML::AuthTX::Request do
  it 'creates a valid xml string' do
    message = PayXML::Message.new( '10011013800', 'test' )
    xml_doc  = Nokogiri::XML(message.xml_string)
    expect(xml_doc.xpath("//protocol").first['ver']).to eq('4.0')
    expect(xml_doc.xpath("//protocol").first['pgid']).to eq('10011013800')
    expect(xml_doc.xpath("//protocol").first['pwd']).to eq('test')
  end

  it 'parses paygate_id from an xml string' do
    message = PayXML::AuthTX::Request.allocate
    message.parse('<protocol ver="4.0" pgid="10011013800" pwd="test"><authtx cref="cust ref 1" cname="Joe Soap" cc="4000000000000002" exp="012008" budp="0" amt="3299" cur="ZAR" cvv="987" bno="" nurl="https://www.mywebsite.com/notify.php" rurl="https://www.mywebsite.com/thanks.php" email="customer@mywebsite.com" ip="196.7.155.70" /></protocol>')
    expect(message.paygate_id).to eq('10011013800')
  end

  it 'parses paygate_password from an xml string' do
    message = PayXML::AuthTX::Request.allocate
    message.parse('<protocol ver="4.0" pgid="10011013800" pwd="test"><authtx cref="cust ref 1" cname="Joe Soap" cc="4000000000000002" exp="012008" budp="0" amt="3299" cur="ZAR" cvv="987" bno="" nurl="https://www.mywebsite.com/notify.php" rurl="https://www.mywebsite.com/thanks.php" email="customer@mywebsite.com" ip="196.7.155.70" /></protocol>')
    expect(message.paygate_password).to eq('test')
  end

  it 'parses customer_reference from an xml string' do
    message = PayXML::AuthTX::Request.allocate
    message.parse('<protocol ver="4.0" pgid="10011013800" pwd="test"><authtx cref="cust ref 1" cname="Joe Soap" cc="4000000000000002" exp="012008" budp="0" amt="3299" cur="ZAR" cvv="987" bno="" nurl="https://www.mywebsite.com/notify.php" rurl="https://www.mywebsite.com/thanks.php" email="customer@mywebsite.com" ip="196.7.155.70" /></protocol>')
    expect(message.customer_reference).to eq('cust ref 1')
  end

  it 'parses customer_reference from an xml string' do
    message = PayXML::AuthTX::Request.allocate
    message.parse('<protocol ver="4.0" pgid="10011013800" pwd="test"><authtx cref="cust ref 1" cname="Joe Soap" cc="4000000000000002" exp="012008" budp="0" amt="3299" cur="ZAR" cvv="987" bno="" nurl="https://www.mywebsite.com/notify.php" rurl="https://www.mywebsite.com/thanks.php" email="customer@mywebsite.com" ip="196.7.155.70" /></protocol>')
    expect(message.customer_name).to eq('Joe Soap')
  end
end
