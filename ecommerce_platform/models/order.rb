# models/order.rb
class Order
    attr_accessor :cart, :total_price, :status
  
    def initialize(cart)
      @cart = cart
      @total_price = cart.total_price
      @status = "Processing"
    end
  
    # Complete the order
    def complete_order
      @status = "Completed"
      @cart.empty
    end
  end
  