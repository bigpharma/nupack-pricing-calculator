require "minitest/autorun"
require "minitest/spec"
require_relative "nupack_calculator"
require 'pry'

#Input: $1,299.99, 3 people, food
#Output: $1,591.58
#Example 2:
#----------
#Input: $5,432.00, 1 person, drugs
#Output: $6,199.81
#Example 3:
#----------
#Input: $12,456.95, 4 people, books
#Output: $13,707.63

describe NupackCalculator do
  before do
    @calculator = NupackCalculator.new
  end

  describe 'when the base price' do
    describe 'is valid' do
      describe 'and there are no workers' do
        describe 'and there is no markup by type of package' do
          it 'there is a 5% increase in cost' do
            base_price = 10
            expected_price = base_price * 1.05
            assert_equal expected_price, @calculator.calculate_markup(base_price, 0, 'Books')
          end
        end
      end
    end

    describe 'is invalid' do
      describe 'base price is 0' do
        it 'an ArgumentError is returned' do
          err = assert_raises ArgumentError do
            @calculator.calculate_markup(0, 1, 'food')
          end
          assert_equal 'Invalid base price', err.message
        end
      end

      describe 'base price is less than 0' do
        it 'an ArgumentError is returned' do
          err = assert_raises ArgumentError do
            @calculator.calculate_markup(-5, 1, 'food')
          end
          assert_equal 'Invalid base price', err.message
        end
      end

      describe 'base price is not a number' do
        it 'an ArgumentError is returned' do
          err = assert_raises ArgumentError do
            @calculator.calculate_markup('100', 1, 'food')
          end
          assert_equal 'Invalid base price', err.message
        end
      end
    end
  end
end
