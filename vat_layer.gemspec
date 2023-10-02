Gem::Specification.new do |spec|
  spec.name           = 'vat_layer'
  spec.version        = '1.0.0'
  spec.authors        = ["Alex Fong, Tom Brammar"]
  spec.email          = ["rubygems-org@premiacapital.com"]
  spec.files          = Dir["lib/vat_layer.rb", 
                          "lib/apilayer/*",
                          "Gemfile",
                          "LICENSE",
                          "Rakefile"
                        ]

  spec.summary        = %q{Ruby wrapper for vatlayer by apilayer. See https://vatlayer.com/ and https://apilayer.com/ for more details.}
  spec.description    = %q{Ruby wrapper for vatlayer by apilayer. This gem depends on the apilayer-ruby-3 gem, which provides a common connection-interface to various services of apilayer.net. See https://apilayer.com/ for more details.}
  spec.homepage       = "https://github.com/actfong/vat_layer"
  spec.licenses       = %w(MIT)

  spec.add_runtime_dependency 'apilayer-ruby-3', '~> 1.0'

  spec.add_development_dependency 'rake', '~> 12.1'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'simplecov', '~> 0.22'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.19'
  spec.add_development_dependency 'rexml', '~> 3.2'
end
