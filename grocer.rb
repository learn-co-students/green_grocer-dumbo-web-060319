def consolidate_cart(cart)
  # code here
  organized_cart = {}
  
  cart.each do |groceries|
    groceries.each do |item, details|
      if !organized_cart.has_key?(item)
        organized_cart[item] = details
        organized_cart[item][:count] = 1 
      else
        organized_cart[item][:count] += 1 
      end
    end
  end
  organized_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |name, properties|
    if properties[:clearance]
      new_price = properties[:price] * 0.80
      properties[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupon_cart)
  total = 0 
  final_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total *= 0.90 if total > 100
  total
end
