require "pry"

def consolidate_cart(cart)
  neat_cart = {}
  cart.map do |groceries|

    groceries.map do |item, details|
      
      if !neat_cart.has_key?(item)
        neat_cart[item] = details
        neat_cart[item][:count] = 1
      else
      neat_cart[item][:count] += 1
      end 

    end

  end
  neat_cart
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
