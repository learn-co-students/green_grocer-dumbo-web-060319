require 'pry'
require 'byebug'

def consolidate_cart(cart)
  cons = {}
  cart.each do |food|
    food.each do |item, item_stats|
      if cons[item]
        cons[item][:count] += 1
      else 
        item_stats[:count] = 1
        cons[item] = item_stats
      end
    end
  end
  binding.pry
  return cons
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
