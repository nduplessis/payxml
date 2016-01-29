require 'spec_helper'

describe 'PayXML::RESULT_CODES' do

  it 'has a call for approval code' do
    expect(PayXML::RESULT_CODES[:call_for_approval]).to be 900001
  end

  it 'has a card expired code' do
    expect(PayXML::RESULT_CODES[:card_expired]).to be 900002
  end

  it 'has an insufficient funds code' do
    expect(PayXML::RESULT_CODES[:insufficient_funds]).to be 900003
  end

  it 'has an invalid card number code' do
    expect(PayXML::RESULT_CODES[:invalid_card_number]).to be 900004
  end

  it 'has a bank interface timeout code' do
    expect(PayXML::RESULT_CODES[:bank_interface_timeout]).to be 900005
  end

  it 'has an invalid card code' do
    expect(PayXML::RESULT_CODES[:invalid_card]).to be 900006
  end

  it 'has a declined code' do
    expect(PayXML::RESULT_CODES[:declined]).to be 900007
  end

  it 'has a lost card code' do
    expect(PayXML::RESULT_CODES[:lost_card]).to be 900009
  end

  it 'has an invalid card length' do
    expect(PayXML::RESULT_CODES[:invalid_card_length]).to be 900010
  end

end
