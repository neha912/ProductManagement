require 'csv'
class Product < ApplicationRecord

  # Import CSV, Find or Create product by its title.description
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      products_hash = row.to_hash
      product = Product.create(name: products_hash['name'], price: products_hash['price'], description: products_hash['description'] )
    end
  end

end
