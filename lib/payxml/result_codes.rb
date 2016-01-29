module PayXML
  RESULT_CODES = {
    :call_for_approval => 900001,
    :card_expired => 900002,
    :insufficient_funds => 900003,
    :invalid_card_number => 900004,
    :bank_interface_timeout => 900005,
    :invalid_card => 900006,
    :declined => 900007,
    :lost_card => 900009,
    :invalid_card_length => 900010,
  }
end
