require File.dirname(__FILE__) + '/../test_helper'
class PostnetTest < Test::Unit::TestCase
  def setup
    @postnet = RBarcode::Postnet.new(
      :text => '40123452356366'
    )
    assert_not_nil @postnet
  end

  def test_to_s
    assert_not_nil @postnet.to_s
  end

  def test_to_img
    assert_nothing_raised { @postnet.to_img('/tmp/postnet.gif') }
  end
end
