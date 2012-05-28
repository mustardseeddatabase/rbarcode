# Author::    Chris Blackburn  (mailto:email4blackburn@gmail.com)
# Copyright:: Copyright (c) 2007 Chris Blackburn
# License::   LGPL

module RBarcode

  # This class takes a string and generates a USPS PLANET based barcode
  # from that string.
  class Planet < Postnet

    # @@encoding key
    # - t => tall bar
    # - s => short bar
    @@encoding = {
      '0' => "ssttt",
      '1' => "tttss",
      '2' => "ttsts",
      '3' => "ttsst",
      '4' => "tstts",
      '5' => "tstst",
      '6' => "tsstt",
      '7' => "sttts",
      '8' => "sttst",
      '9' => "ststt"
    }
  end
end
