# Original Author::    Clinton R. Nixon <crnixon@gmail.com>
# Copyright:: Copyright (c) 2005 Demand Publishing
# License::   Distributes under the same terms as Ruby
# Version:: 0.2

# Repackaging Author::    Chris Blackburn  (mailto:email4blackburn@gmail.com)
# Copyright:: Copyright (c) 2007 Chris Blackburn
# License::   Distributes under the same terms as Ruby

module RBarcode

  # This class takes a string and generates a Code 39-based barcode
  # from that string.
  class Code39 < Base

    API_VERSION = "0.2"

    # quick reference as to what's up with @@encoding:
    # - B => large solid bar
    # - b => small solid bar
    # - W => large space
    # - w => small space
    @@encoding = {
      '0' => "bwbWBwBwb",
      '1' => "BwbWbwbwB",
      '2' => "bwBWbwbwB",
      '3' => "BwBWbwbwb",
      '4' => "bwbWBwbwB",
      '5' => "BwbWBwbwb",
      '6' => "bwBWBwbwb",
      '7' => "bwbWbwBwB",
      '8' => "BwbWbwBwb",
      '9' => "bwBWbwBwb",
      'A' => "BwbwbWbwB",
      'B' => "bwBwbWbwB",
      'C' => "BwBwbWbwb",
      'D' => "bwbwBWbwB",
      'E' => "BwbwBWbwb",
      'F' => "bwBwBWbwb",
      'G' => "bwbwbWBwB",
      'H' => "BwbwbWBwb",
      'I' => "bwBwbWBwb",
      'J' => "bwbwBWBwb",
      'K' => "BwbwbwbWB",
      'L' => "bwBwbwbWB",
      'M' => "BwBwbwbWb",
      'N' => "bwbwBwbWB",
      'O' => "BwbwBwbWb",
      'P' => "bwBwBwbWb",
      'Q' => "bwbwbwBWB",
      'R' => "BwbwbwBWb",
      'S' => "bwBwbwBWb",
      'T' => "bwbwBwBWb",
      'U' => "BWbwbwbwB",
      'V' => "bWBwbwbwB",
      'W' => "BWBwbwbwb",
      'X' => "bWbwBwbwB",
      'Y' => "BWbwBwbwb",
      'Z' => "bWBwBwbwb",
      '-' => "bWbwbwBwB",
      '.' => "BWbwbwBwb",
      ' ' => "bWBwbwBwb",
      '$' => "bWbWbWbwb",
      '/' => "bWbWbwbWb",
      '+' => "bWbwbWbWb",
      '%' => "bwbWbWbWb",
      '*' => "bWbwBwBwb"
    }

    # Takes a string, uppercases it, and wraps it in asterisks.
    # If any character is unavailable in Code 39 encoding,
    # throws a vicious error.
    def initialize(options = {})
      @required =  [:text]
      super
      @text.upcase!
      @text.split(//).each do |char|
        if not @@encoding.has_key?(char)
          raise "Unencodable string."
        end
      end

      @text = "*#{@text}*"
    end

    # Outputs a string that represents the encoding.
    # Not necessarily useful externally, but
    # who knows?
    def to_s
      output = String.new
      @text.split(//).each do |char|
        output += @@encoding[char] + " "
      end
      return output
    end

    # The overly complicated image generation code.
    # Your barcode image width and height should be in pixels.
    # The actual barcode will not be that width, instead
    # it will be a multiple of your text string (plus two
    # asterisks - @text) length * 14. White space will center
    # the rest.
    # align is set to :left, :right or :center
    def to_img(filename, width, height, align)
      bar_code_width = width - (width % ( @text.length * 14 ) )
      letter_width = bar_code_width / @text.length
      small_bar_width = letter_width / 14
      large_bar_width = ((7.0 / 3.0) * small_bar_width.to_f).to_i
      canvas = Image.new(width, height)
      gc = Draw.new
      gc.fill('black')
      gc.stroke('black')
      gc.stroke_width(-1)
      # Necessary to prevent massive blurry image nonsense.
      gc.stroke_antialias(false)

      w = width - bar_code_width

      cur_x = case align
                when :left
                  0
                when :right
                  w
                else # center
                  w/2
                end

      self.to_s.split(//).each do |char|
         if char.upcase == "B"
            gc.rectangle(cur_x, 0, cur_x + (char == "B" ? large_bar_width : small_bar_width), height)
         end
         cur_x += char.match(/[BW]/) ? large_bar_width : small_bar_width
      end
      gc.draw(canvas)
      canvas.write(filename)
    end
  end
end
