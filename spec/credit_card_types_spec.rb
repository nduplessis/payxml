require 'spec_helper'

describe 'PayXML::CREDIT_CARD_TYPES' do

  it 'has an unknown type' do
    expect(PayXML::CREDIT_CARD_TYPES[:unknown]).to be 0
  end

  it 'has a visa type' do
    expect(PayXML::CREDIT_CARD_TYPES[:visa]).to be 1
  end

end
