# Author::    Chris Blackburn  (mailto:email4blackburn@gmail.com)
# Copyright:: Copyright (c) 2007 Chris Blackburn
# License::   LGPL

module RBarcode

  VERSION = "0.0.2"

  class RBarcodeError < StandardError; end
  class RBarcodeRequiredFieldError < StandardError; end

  class Base
    attr_reader :required

    attr_writer :text

    def initialize(options = {})
      prefs = File.expand_path(options[:prefs] || "~/.rbarcode.yml")
      YAML.load(File.open(prefs)).each {|pref, value| eval("@#{pref} = #{value.inspect}")} if File.exists?(prefs)

      @required = Array.new

      # include all provided data
      options.each do |method, value|
        instance_variable_set("@#{method}", value)
      end
    end

    # Initializes an instance of RBarcode::Code39 with the same instance variables as the base object
    def code39
      RBarcode::Code39.new prepare_vars
    end

    # Initializes an instance of RBarcode::Postnet with the same instance variables as the base object
    def postnet
      RBarcode::Postnet.new prepare_vars
    end

    #####################################################################
    private

    def prepare_vars #:nodoc:
      h = eval(%q[instance_variables.map {|var| "#{var.gsub("@",":")} => #{eval(var+'.inspect')}"}.join(", ").chomp(", ")])
      return eval("{#{h}}")
    end

    # Make sure that the required fields are not empty
    def check_required
      for var in @required
        raise RBarcodeRequiredFieldError, "The #{var} variable needs to be set" if eval("@#{var}").nil?
      end
    end

  end
end
