# Author::    Chris Blackburn  (mailto:email4blackburn@gmail.com)
# Copyright:: Copyright (c) 2007 Chris Blackburn
# License::   LGPL

module RBarcode

  # This class takes a string and generates a Code 39-based barcode
  # from that string.
  class Postnet < Base

    API_VERSION = "0.1"
    BAR_SHORT_HEIGHT = 7
    BAR_TALL_HEIGHT = 15
    BAR_WIDTH = 2

    # @@encoding key
    # - t => tall bar
    # - s => short bar
    @@encoding = {
      '0' => "ttsss",
      '1' => "ssstt",
      '2' => "sstst",
      '3' => "sstts",
      '4' => "stsst",
      '5' => "ststs",
      '6' => "sttss",
      '7' => "tssst",
      '8' => "tssts",
      '9' => "tstss"
    }

    # Pass it a hash with :text => number
    def initialize(options = {})
      @required =  [:text]
      super
      @text.split(//).each do |char|
        if not @@encoding.has_key?(char)
          raise "Unencodable string."
        end
      end
      @text = "#{@text}"
    end

    # Passes back encoding
    def to_s
      output = ''
      @text.split(//).each do |char|
        output += @@encoding[char]
      end
      return output
    end

    # RMagic image generation code
    # Barcode image width and height should be in pixels.
    def to_img(filename)
      bar_code_width = @text.length * 2 * 5 * BAR_WIDTH + BAR_WIDTH * 3;

      #canvas = Image.new(width, height)
      canvas = Image.new(bar_code_width, BAR_TALL_HEIGHT)
      gc = Draw.new
      gc.fill('black')
      gc.stroke('black')
      gc.stroke_width(-1)
      # Necessary to prevent massive blurry image nonsense.
      gc.stroke_antialias(false)

      cur_x = 0

      # draw the start framing bar
      gc.rectangle(cur_x, 0, cur_x + BAR_WIDTH, BAR_TALL_HEIGHT)
      cur_x += BAR_WIDTH * 2

      #stsst ttsss ssstt sstst sstts stsst ststs sstst sstts ststs sttss sstts sttss sttss
      self.to_s.split(//).each do |char|
        if char == 't'
          gc.rectangle(cur_x, 0, cur_x + BAR_WIDTH, BAR_TALL_HEIGHT)
        else
          gc.rectangle(cur_x, (BAR_TALL_HEIGHT - BAR_SHORT_HEIGHT), cur_x + BAR_WIDTH, BAR_TALL_HEIGHT)
        end
        cur_x += BAR_WIDTH * 2
      end

      # draw the end framing bar
      gc.rectangle(cur_x, 0, cur_x + BAR_WIDTH - 1, BAR_TALL_HEIGHT)
      cur_x += BAR_WIDTH * 2

      gc.draw(canvas)
      canvas.write(filename)
    end
  end
end
