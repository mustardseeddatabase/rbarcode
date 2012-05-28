# Rbarcode

RBarcode is a module to generate bar codes.  It currently supports Code39 and USPS (PLANET and POSTNET) code generation using RMagick.

This repo is a copy of the original (which was not on github, hence no fork), with changes.

The original can be found at: http://rubyforge.org/projects/rbarcode

## Installation

Add this line to your application's Gemfile:

    gem 'rbarcode', :git => 'git://github.com/mustardseeddatabase/rbarcode.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbarcode

## Usage

@planet = RBarcode::Planet.new(:text => '40123452356366')
@postnet = RBarcode::Postnet.new(:text => '40123452356366')
@code39 = RBarcode::Code39.new(:text => 'This is my test')

It is up to the user to generate proper USPS bar codes by following the USPS guidelines.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
