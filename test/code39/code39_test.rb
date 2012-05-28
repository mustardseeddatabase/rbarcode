require File.dirname(__FILE__) + '/../test_helper'
class Code39Test < Test::Unit::TestCase
  def setup
    @code39 = RBarcode::Code39.new(
      :text => '40123452356366'
    )
  end

  def test_to_s
    assert_not_nil @code39.to_s
  end

  def test_to_img
    assert_nothing_raised { @code39.to_img('/tmp/code39.gif', 250, 40) }
  end
end