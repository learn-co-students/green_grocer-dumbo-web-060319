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
  return cons
end

def apply_coupons(cart, coupons)
newhash = {}

cart.each do |key, value|
  newhash[key] = value
  coupons.each do |info|
    info.each do |k, v|
      if key == v && cart[key][:count] >= info[:num]
        newhash[key][:count] = cart[key][:count] - info[:num]
        if newhash["#{key} W/COUPON"]
           newhash["#{key} W/COUPON"][:count] += 1
        else
          newhash["#{key} W/COUPON"] = {}
          newhash["#{key} W/COUPON"][:price] = info[:cost]
          newhash["#{key} W/COUPON"][:clearance] = cart[key][:clearance]
          newhash["#{key} W/COUPON"][:count] = 1
        end
      end
    end
  end
end
return newhash
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      discount = info[:price] * (0.2)
      info[:price] = info[:price] - discount
    end
  end 
  return cart
end

def checkout(cart, coupons)
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  total = 0
  discount = 0

  cart.each do |item, info|
    total += info[:price] * info[:count]
    
  end
  if total >= 100
    discount = total * 0.1
      total -= discount
  end
  
  return total
end