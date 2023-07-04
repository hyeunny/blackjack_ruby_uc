require "test_helper"
require 'minitest/spec'

class CardTest < ActiveSupport::TestCase
  describe '#new', 'initializing a card' do
    it 'raises an argument error with invalid value arg' do
      assert_raises(ArgumentError) do
        Card.new('foo', 'DIAMOND')
      end
    end

    it 'raises an argument error with invalid suit arg' do
      assert_raises(ArgumentError) do
        Card.new('J', 'baz')
      end
    end
  end
end
