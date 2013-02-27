# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rbarcode/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Les Nightingill", "Chris Blackburn"]
  gem.email         = ["codehacker@comcast.net"]
  gem.description   = %q{Lightweight barcode generator for code39 and USPS format barcodes}
  gem.summary       = %q{No checksums or encoding is implemented. This gem converts a string into a barcode graphic file}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rbarcode"
  gem.require_paths = ["lib"]
  gem.version       = Rbarcode::VERSION

  gem.add_dependency 'rmagick', '~>2.13.1'
end
