require 'spec_helper'

describe PayXML::Auth do
  describe PayXML::Auth::Request do
    before(:context) do
      @message = PayXML::Auth::Request.new('10011013800', 'test')
      @message.customer_reference = 'cust ref 1'
      @message.customer_name = 'Joe Soap'
      @message.credit_card_number = '4000000000000002'
      @message.expiry_date = '122016'
      @message.currency = 'ZAR'
      @message.amount = 3250
      @message.budget_period = 12
      @message.bno = '12345'
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

    it 'creates an expity_date attribute' do
      expect(@xml_doc.xpath("//authtx").first['exp']).to eq('122016')
    end

    it 'creates a currency attribute' do
      expect(@xml_doc.xpath("//authtx").first['cur']).to eq('ZAR')
    end

    it 'creates an amount attribute' do
      expect(@xml_doc.xpath("//authtx").first['amt']).to eq('3250')
    end

    it 'creates a budget_period attribute' do
      expect(@xml_doc.xpath("//authtx").first['budp']).to eq('12')
    end

    it 'creates a bno attribute' do
      expect(@xml_doc.xpath("//authtx").first['bno']).to eq('12345')
    end
  end #describe PayXML::Auth::Request

  describe PayXML::Auth::Response do
    describe 'parse response without secure redirect' do
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

      it 'requires secure redirect' do
        expect(@message.requires_secure_redirect?).to eq(false)
      end
    end

    describe 'parse response with secure redirect' do
      before(:context) do
        @message = PayXML::Auth::Response.allocate
        @message.parse('<protocol ver="4.0" pgid="10011013800" pwd="test"><securerx tid="123456" cref="cust ref 1" url="https://www.paygate.co.za/3dsecure/3dsecure.trans" chk="ab12cd34ef56gh78ij90kl12mn34op56" /></protocol>')
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

      it 'parses secure_redirect_url from an xml string' do
        expect(@message.secure_redirect_url).to eq('https://www.paygate.co.za/3dsecure/3dsecure.trans')
      end

      it 'parses secure_checksum from an xml string' do
        expect(@message.secure_checksum).to eq('ab12cd34ef56gh78ij90kl12mn34op56')
      end

      it 'requires secure redirect' do
        expect(@message.requires_secure_redirect?).to eq(true)
      end
    end
  end #describe PayXML::Auth::Response

end
