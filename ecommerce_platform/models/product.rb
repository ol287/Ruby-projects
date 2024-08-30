# models/product.rb
class Product
    attr_accessor :id, :name, :price, :description, :stock
  
    def initialize(id, name, price, description, stock)
      @id = id
      @name = name
      @price = price
      @description = description
      @stock = stock
    end
  
    # Check if the product is in stock
    def in_stock?
      @stock > 0
    end
  
    # Decrease stock when a product is purchased
    def purchase(quantity)
      @stock -= quantity if quantity <= @stock
    end
  end
  