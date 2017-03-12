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

#NuPack is responsible for taking existing products and repackaging them for sale at electronic stores like Best Buy.
# Companies will phone up NuPack, explain the process and NuPack needs to quickly give them an estimate of how much it will cost. Different markups to the job:
#* Without exception, there is a flat markup on all jobs of 5%
#* For each person that needs to work on the job, there is a markup of 1.2%
#Markups are also added depending on the types of materials involved:
#* If pharmaceuticals are involved, there is an immediate 7.5% markup
#* For food, there is a 13% markup
#* Everything else, there is no markup
#Another system calculates the base price depending on how many products need to be repackaged.
# As such, the markup calculator should accept the initial base price along with the different categories of markups and calculate a final cost for a project.
#The flat markup is calculated first and then all other markups are calculated on top of the base price plus flat markup.
#Example 1:
#----------
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
