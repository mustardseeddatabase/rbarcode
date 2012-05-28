require File.dirname(__FILE__) + '/../test_helper'
class BaseTest < Test::Unit::TestCase
  def setup
    @bc = RBarcode::Base.new(
      :text => '40123452356366'
    )
  end

  def test_code39
    code39 = @bc.code39
    assert_instance_of RBarcode::Code39, code39
  end

  def test_postnet
    postnet = @bc.postnet
    assert_instance_of RBarcode::Postnet, postnet
  end
end