require 'spec_helper'

describe PayXML::Message do
  before(:context) do
    error_message = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE protocol SYSTEM "https://www.paygate.co.za/payxml/payxml_v4.dtd"><protocol ver="4.0" pgid="10011013800" pwd="test" ><errorrx ecode="101" edesc="Notify URL Required For Authenticated Transaction" /></protocol>'
    @error = PayXML::Error.allocate
    @error.parse(error_message)
  end

  it 'parses the error code' do
    expect(@error.code).to eq('101')
  end

  it 'parses the error description' do
    expect(@error.description).to eq('Notify URL Required For Authenticated Transaction')
  end
end
