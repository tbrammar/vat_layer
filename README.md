## vat_layer

![Master branch status](https://github.com/tbrammar/apilayer-ruby3/actions/workflows/main.yml/badge.svg)

Ruby wrapper for vatlayer of apilayer. See https://vatlayer.com/ and
http://apilayer.com for more details.

This is a fork of the original gem [vat_layer](https://github.com/actfong/vat_layer) to work under Ruby 3.0

## Installation

### Using Bundler

Add `vat_layer-ruby-3` in your `Gemfile`:

    gem 'vat_layer-ruby-3', '~> 1.0'

### Usage

#### Add to your application
    require "vat_layer"

#### Set up vat_layer
Once you have signed up for **vatlayer.com**, you will receive an access_key. 
Then configure your Apilayer::Vat module like this:

    Apilayer::Vat.configure do |configs|
      configs.access_key = "my_access_key_123"
      configs.https = true
    end

Please note that the https configuration is optional and only available to
paid-accounts. If unset, these configuration-values are just nil.

You can always review you configurations with:

    Apilayer::Vat.configs

Once your configurations are set, you are ready to go

#### vatlayer
After setting the access_key for **vatlayer**, you can use Apilayer::Vat to
call **vatlayer**'s API

    Apilayer::Vat.validate("LU26375245")
    Apilayer::Vat.rate(:country_code, "NL")
    Apilayer::Vat.rate(:ip_address, "176.249.153.36")
    Apilayer::Vat.rate_list
    Apilayer::Vat.price(100, :country, "NL")
    Apilayer::Vat.price(100, :ip_address, "176.249.153.36")

#### Re-Configure access_key and https
If you happened to have forgotten to set or entered an incorrect value, you
can re-configure your Apilayer module by:

    # Example: reconfigure https
    Apilayer::Vat.configure do |configs|
      configs.https = true
    end