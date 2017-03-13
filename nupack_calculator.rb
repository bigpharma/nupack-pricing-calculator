require 'pry'

class NupackCalculator
  MATERIAL_MARKUPS = { 'food' => 0.13, 'drugs' => 0.075 }

  # Calculate the markup for a product based on base price, number of workers
  # needed, and package type
  # Assumes that the base price can not be <= 0 and that there needs to be
  # at least one worker assigned
  def calculate_markup(base_price, number_of_workers, package_type)
    fail ArgumentError, 'Invalid base price' if invalid_numeric_input?(base_price)
    fail ArgumentError, 'Invalid number of workers' if invalid_numeric_input?(number_of_workers)

    flat_fee = 1.05
    base_price_with_flat_markup = base_price * flat_fee
    worker_markup = base_price_with_flat_markup * number_of_workers * 0.012
    material_markup = if MATERIAL_MARKUPS.include?(package_type)
                        base_price_with_flat_markup * MATERIAL_MARKUPS[package_type]
                      else
                        0.0
                      end

    total_fee = (base_price_with_flat_markup + worker_markup + material_markup)
    return total_fee.round(2)
  end

  private

  def invalid_numeric_input?(input)
    return (!input.is_a?(Numeric) || input < 1)
  end
end
