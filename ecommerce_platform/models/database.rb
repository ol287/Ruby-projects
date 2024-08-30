# models/database.rb
class Database
    def initialize
      @products = []
      @orders = []
    end
  
    # Load sample data into the database
    def load_sample_data
      @products << Product.new(1, "Laptop", 1200, "A high-performance laptop.", 10)
      @products << Product.new(2, "Smartphone", 800, "A latest model smartphone.", 15)
      @products << Product.new(3, "Headphones", 200, "Noise-cancelling headphones.", 30)
    end
  
    # Retrieve all products
    def all_products
      @products
    end
  
    # Find a product by ID
    def find_product(id)
      @products.find { |product| product.id == id }
    end
  
    # Add an order to the database
    def add_order(order)
      @orders << order
    end
  
    # Retrieve all orders
    def all_orders
      @orders
    end
  end
  