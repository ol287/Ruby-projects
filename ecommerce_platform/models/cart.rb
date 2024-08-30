# models/cart.rb
class Cart
    attr_accessor :items
  
    def initialize
      @items = []
    end
  
    # Add a product to the cart
    def add_product(product)
      @items << product
    end
  
    # Calculate the total price of the cart
    def total_price
      @items.reduce(0) { |sum, product| sum + product.price }
    end
  
    # Empty the cart
    def empty
      @items = []
    end
  end
  