#:mode=ruby:
require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rubyforge'
require File.dirname(__FILE__) + '/lib/rbarcode'

PKG_VERSION = RBarcode::VERSION
PKG_NAME = "rbarcode"
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"
RUBY_FORGE_PROJECT = "rbarcode"
RUBY_FORGE_USER = ENV['RUBY_FORGE_USER'] || "cblackburn"
RELEASE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

PKG_FILES = FileList[
    "lib/**/*", "bin/*", "test/**/*", "[A-Z]*", "Rakefile", "doc/**/*"
]

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the r_barcode plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

# Make a console, useful when working on tests
desc "Generate a test console"
task :console do
   verbose( false ) { sh "irb -I lib/ -r 'rbarcode'" }
end

desc 'Generate documentation for the r_barcode plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Ruby Barcode Generator'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Generate the gem package
spec = Gem::Specification.new do |s|
  s.name = 'rbarcode'
  s.platform = Gem::Platform::RUBY
  s.version = PKG_VERSION
  s.summary = "A module for code39 and USPS barcode generation."
  s.description = "Allows easy barcode image generation for code39 and USPS type barcodes."
  s.files = PKG_FILES

  s.add_dependency('rmagick', '>= 1.15.9')
  s.requirements << "ImageMagick and GraphicsMagick interface for Ruby."
  s.require_path = 'lib'
  s.autorequire = 'rbarcode'
  s.has_rdoc = true

  #### Author and project details.
  s.author = "Chris Blackburn"
  s.email = "email4blackburn@gmail.com"
  s.homepage = "http://www.cbciweb.com/"
  s.rubyforge_project = "rbarcode"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
  pkg.need_zip = true
  pkg.need_tar = true
end

desc "Report code statistics (KLOCs, etc) from the application"
task :stats do
  require 'code_statistics'
  CodeStatistics.new(
    ["Library", "lib"],
    ["Units", "test"]
  ).to_s
end

desc "Publish new documentation"
task :publish => [:package] do
  #Rake::SshFilePublisher.new("cblackburn@cbciweb.com", "public_html/gems/gems", "pkg", "#{PKG_FILE_NAME}.gem").upload
  Rake::RubyForgePublisher.new('rbarcode', RUBY_FORGE_USER).upload
  #`ssh cbci update-rbarcode-doc`
end

desc "Publish the release files to RubyForge."
task :upload => [:package] do
  files = ["gem", "tgz", "zip"].map { |ext| "pkg/#{PKG_FILE_NAME}.#{ext}" }

  if RUBY_FORGE_PROJECT then
    rubyforge = RubyForge.new
    group_id, package_id, release_name = [RUBY_FORGE_PROJECT, PKG_NAME, RELEASE_NAME]
    rubyforge.scrape_config

    ac = rubyforge.autoconfig
    if ! ac["package_ids"].include?(PKG_NAME)
      rubyforge.create_package(RUBY_FORGE_PROJECT, PKG_NAME)
      puts "Updating package_id for #{RUBY_FORGE_PROJECT}"
      rubyforge.scrape_project(RUBY_FORGE_PROJECT)
    end

    first_file = true
    files.each do |filename|
      group_id = Integer(group_id) rescue group_id
      package_id = Integer(package_id) rescue package_id

      if first_file
        rubyforge.add_release group_id, package_id, release_name, filename
        first_file = false
      else
        rubyforge.add_file group_id, package_id, release_name, filename
      end
    end

  end
end

begin
  if !defined?(USE_TERMIOS) || USE_TERMIOS
    require 'termios'
  else
    raise LoadError
  end

  # Enable or disable stdin echoing to the terminal.
  def echo(enable)
    term = Termios::getattr(STDIN)

    if enable
      term.c_lflag |= (Termios::ECHO | Termios::ICANON)
    else
      term.c_lflag &= ~Termios::ECHO
    end

    Termios::setattr(STDIN, Termios::TCSANOW, term)
  end
rescue LoadError
  def echo(enable)
  end
end
