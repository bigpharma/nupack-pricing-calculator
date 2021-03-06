require "minitest/autorun"
require "minitest/spec"
require_relative "nupack_calculator"
require 'pry'

describe NupackCalculator do
  before do
    @calculator = NupackCalculator.new
  end

  describe 'when the base price' do
    describe 'is a valid input' do
      describe 'the worker count' do
        describe 'is a valid input' do
          describe 'there is one worker' do
            describe 'and there is no markup by type of package' do
              it 'there is a 6.2% increase in cost' do
                base_price = 10.0
                expected_price = (base_price * 1.05 * 1.012).round(2)
                assert_equal expected_price, @calculator.calculate_markup(base_price, 1, 'Books')
              end
            end

            describe 'and there is markup by the type of package' do
              let(:base_price) { 10 }
              let(:base_price_with_flat_markup) { base_price * 1.05 }
              let(:worker_markup) { base_price_with_flat_markup * 0.012 }

              describe 'the type of package is Food' do
                it 'there is a 13% markup' do
                  material_markup = base_price_with_flat_markup * 0.13
                  expected_price = (base_price_with_flat_markup + material_markup + worker_markup).round(2)
                  assert_equal expected_price, @calculator.calculate_markup(base_price, 1, 'food')
                end
              end

              describe 'the type of package is pharmaceuticals' do
                it 'there is a 7.5% markup' do
                  material_markup = base_price_with_flat_markup * 0.075
                  expected_price = (base_price_with_flat_markup + material_markup + worker_markup).round(2)
                  assert_equal expected_price, @calculator.calculate_markup(base_price, 1, 'drugs')

                  # Testing the same thing, could be in another 'it' block
                  expected_price = 6199.81
                  assert_equal expected_price, @calculator.calculate_markup(5432.00, 1, 'drugs')
                end
              end
            end
          end

          describe 'there are four workers' do
            describe 'and there is no markup by type of package' do
              it 'there is a 9.8% increase in cost' do
                base_price = 12456.95
                expected_price = 13707.63
                assert_equal expected_price, @calculator.calculate_markup(base_price, 4, 'Books')
              end
            end
          end

          describe 'there are three workers' do
            describe 'there is markup by type of package' do
              it 'calculates the markup correctly' do
                expected_price = 1591.58
                assert_equal expected_price, @calculator.calculate_markup(1299.99, 3, 'food')
              end
            end
          end
        end

        describe 'is an invalid input' do
          describe 'number of workers is 0' do
            it 'an ArgumentError is returned' do
              err = assert_raises ArgumentError do
                @calculator.calculate_markup(1, 0, 'food')
              end
              assert_equal 'Invalid number of workers', err.message
            end
          end

          describe 'number of workers is less than 0' do
            it 'an ArgumentError is returned' do
              err = assert_raises ArgumentError do
                @calculator.calculate_markup(1, -1, 'food')
              end
              assert_equal 'Invalid number of workers', err.message
            end
          end

          describe 'number of workers is not a number' do
            it 'an ArgumentError is returned' do
              err = assert_raises ArgumentError do
                @calculator.calculate_markup(1, '1', 'food')
              end
              assert_equal 'Invalid number of workers', err.message
            end
          end
        end
      end
    end

    describe 'is an invalid input' do
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
