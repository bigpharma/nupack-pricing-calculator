require 'pry'

class NupackCalculator
  MATERIAL_MARKUPS = { 'food' => 0.13, 'drugs' => 0.075 }

  def calculate_markup(base_price, number_of_workers, package_type)
    fail ArgumentError, 'Invalid base price' if !base_price.is_a?(Numeric) || base_price < 1
    fail ArgumentError, 'Invalid number of workers' if !number_of_workers.is_a?(Numeric) || number_of_workers < 1

    flat_fee = 1.05
    base_price_with_flat_markup = base_price * flat_fee

    worker_markup = base_price_with_flat_markup * number_of_workers * 0.012

    if MATERIAL_MARKUPS.include?(package_type)
      material_markup = base_price_with_flat_markup * MATERIAL_MARKUPS[package_type]
    else
      material_markup = 0.0
    end

    total_fee = (base_price_with_flat_markup + worker_markup + material_markup)
    return total_fee.round(2)
  end
end
