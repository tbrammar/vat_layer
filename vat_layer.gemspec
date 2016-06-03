Gem::Specification.new do |spec|
  spec.name           = 'vat_layer'
  spec.version        = '0.1.1'
  spec.authors        = ["Alex Fong"]
  spec.email          = ["actfong@gmail.com"]
  spec.files          = Dir["lib/vatlayer.rb", 
                          "lib/apilayer/*",
                          "Gemfile",
                          "LICENSE",
                          "Rakefile",
                          "README.rdoc"
                        ]

  spec.summary        = %q{Ruby wrapper for vatlayer by apilayer. See https://vatlayer.com/ and https://apilayer.com/ for more details.}
  spec.description    = %q{Ruby wrapper for vatlayer by apilayer. This gem depends on the apilayer gem, which provides a common connection-interface to various services of apilayer.net (such as currencylayer and vatlayer). See https://currencylayer.com/ and https://apilayer.com/ for more details.}
  spec.homepage       = "https://github.com/actfong/vat_layer"
  spec.licenses       = %w(MIT)

  spec.add_runtime_dependency 'apilayer', '~> 2.0', '>= 2.0.0'

  spec.add_development_dependency 'rake', '~> 10.1', '>= 0.10.1'
  spec.add_development_dependency 'pry', '~> 0.10', '>= 0.10.1'
  spec.add_development_dependency 'bundler', '~> 1.7', '>= 1.7.9'
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
  spec.add_development_dependency 'simplecov', '~> 0.11', '>= 0.11.0'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.1'
  spec.add_development_dependency 'webmock', '~> 2.0', '>= 2.0.1'
end
