require "minitest/autorun"
require "minitest/spec"
require_relative "nupack_calculator"

describe NupackCalculator do
  before do
    @calculator = NupackCalculator.new
  end

  describe 'the Nupack calculator' do
    it 'is initialized' do
      assert @calculator
    end
  end
end
