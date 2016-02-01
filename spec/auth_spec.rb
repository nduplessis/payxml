require 'spec_helper'

describe PayXML::Auth do
  describe PayXML::Auth::Request do
    before(:context) do
      @message = PayXML::Auth::Request.new('10011013800', 'test')
      @message.customer_reference = 'cust ref 1'
      @message.customer_name = 'Joe Soap'
      @message.credit_card_number = '4000000000000002'

      @xml_doc  = Nokogiri::XML(@message.xml_string)

    end

    it 'creates the protocol header' do
      expect(@xml_doc.xpath("//protocol").first['ver']).to eq('4.0')
      expect(@xml_doc.xpath("//protocol").first['pgid']).to eq('10011013800')
      expect(@xml_doc.xpath("//protocol").first['pwd']).to eq('test')
    end

    it 'creates a cref attribute' do
      expect(@xml_doc.xpath("//authtx").first['cref']).to eq('cust ref 1')
    end

    it 'creates a cname attribute' do
      expect(@xml_doc.xpath("//authtx").first['cname']).to eq('Joe Soap')
    end

    it 'creates a cc attribute' do
      expect(@xml_doc.xpath("//authtx").first['cc']).to eq('4000000000000002')
    end
  end #describe PayXML::AuthTX::Request

  describe PayXML::Auth::Response do
    describe 'parse' do
      before(:context) do
        @message = PayXML::Auth::Response.allocate
        @message.parse('<protocol ver="4.0" pgid="10011013800" pwd="test"><authrx tid="123456" cref="cust ref 1" stat="1" sdesc="Approved" res="990017" rdesc="Auth Done" bno="" auth="F45287" risk="AX" ctype="1" /></protocol>')
      end

      it 'parses paygate_id from an xml string' do
        expect(@message.paygate_id).to eq('10011013800')
      end

      it 'parses paygate_password from an xml string' do
        expect(@message.paygate_password).to eq('test')
      end

      it 'parses customer_reference from an xml string' do
        expect(@message.customer_reference).to eq('cust ref 1')
      end

      it 'parses transaction_id from an xml string' do
        expect(@message.transaction_id).to eq('123456')
      end

      it 'parses card_type from an xml string' do
        expect(@message.card_type).to eq('1')
      end

      it 'parses transaction_status from an xml string' do
        expect(@message.transaction_status).to eq('1')
      end

      it 'parses bno from an xml string' do
        expect(@message.bno).to eq('')
      end

      it 'parses result_code from an xml string' do
        expect(@message.result_code).to eq('990017')
      end

      it 'parses result_description from an xml string' do
        expect(@message.result_description).to eq('Auth Done')
      end

      it 'parses authorisation_code from an xml string' do
        expect(@message.authorisation_code).to eq('F45287')
      end

      it 'parses risk from an xml string' do
        expect(@message.risk).to eq('AX')
      end
    end
  end #describe PayXML::AuthTX::Response

end