require "pry"
def consolidate_cart(cart)
  new_hash = {}
  cart.each do |items|
    items.each do |item, information|
      if !new_hash.include?(item)
        new_hash[item] = information
        new_hash[item][:count] = 1
      else
        new_hash[item][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.include?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      multiplier = 0
      result = cart[coupon[:item]][:count]
      while result >= coupon[:num]
        result -= coupon[:num]
        multiplier += 1
      end
  	  cart[coupon[:item]][:count] -= coupon[:num] * multiplier
  	  cart[coupon[:item] + " W/COUPON"] = {price: coupon[:cost], clearance: cart[coupon[:item]][:clearance], count: 1 * multiplier}
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, details|
    if details[:clearance]
      details[:price] *= 0.80
      details[:price] = details[:price].round(1)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0.00
  cart.each do |item, details|
    total += details[:price] * details[:count]
  end
  if total > 100.00
    total *= 0.90
    total.round(1)
  else
  	total.round(1)
  end
end
