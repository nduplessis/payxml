require 'spec_helper'

describe PayXML do
  it 'has a version number' do
    expect(PayXML::VERSION).not_to be nil
  end

  it 'calculates the correct md5 checksum' do
    values = ['10011013800', 'Customer1', '1', '1', '990017', 'Auth Done', 'F45287', '123456', 'AX', 'test']
    checksum = PayXML::PayXML.checksum(values)
    expect(checksum).to eq '4dc17f0c2bc00daa219eda7faf89638d'
  end
end
