def consolidate_cart(cart)
  new_hash = {}
  cart.each do |hashes|
    hashes.each do |product, info|
      if !new_hash.include?(product)
        new_hash[product] = info
        new_hash[product][:count] = 1
      else
        new_hash[product][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    name = coupon_hash[:item]
    if cart[name] && cart[name][:count] >= coupon_hash[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon_hash[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon_hash[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |products, infos|
    if infos[:clearance] == true
      infos[:price] -= infos[:price] * (0.20)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(cart, coupons)
  final_cart = apply_clearance(coupon_cart)
  total = 0
  final_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total *= 0.90 if total > 100
  total
end
