[![Build Status](https://travis-ci.org/nduplessis/payxml.svg?branch=master)](https://travis-ci.org/nduplessis/payxml)

# PayXML

PayXML is an easy use wrapper for the the PayGate PayXML payment gateway API.

https://www.paygate.co.za

Compatible with:
- `PayXML 4.0`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payxml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payxml

## Usage

### Test vs Production

### Example

```ruby
require 'payxml'

payxml = PayXML::PayXML.new( '10011013800', 'test' )
response = payxml.authorise({customer_name: 'John Doe', customer_reference: 'customer ref 1', credit_card_number: '4000000000000002', expiry_date: '122018', cvv: '123', amount: '30020', currency: 'ZAR', notify_callback_url: 'http://mysite.dev/notify', response_url: 'http://mysite.dev/order-complete'})

if response.requires_secure_redirect?
  # redirect to response.secure_redirect_url
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nduplessis/payxml. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
