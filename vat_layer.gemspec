Gem::Specification.new do |spec|
  spec.name           = 'vat_layer'
  spec.version        = '1.1.0'
  spec.authors        = ["Alex Fong"]
  spec.email          = ["actfong@gmail.com"]
  spec.files          = Dir["lib/vat_layer.rb", 
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

  spec.add_runtime_dependency 'apilayer', '~> 2.1'

  spec.add_development_dependency 'rake', '~> 12.1'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'simplecov', '~> 0.14'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.4'
end
