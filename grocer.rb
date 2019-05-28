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
  clipped_cart = {}
  

  cart.map do |item, details|
    # the array holds the coupons (hash)

    coupons.map do |coupon|
      # coupon[:item, :num, :cost], value
        
      # if the cart's "item" matches the coupon's :item => value
      if item == coupon[:item]
        # make a string for the item with discount. This will become our key.
        clipped_item = "#{item} W/COUPON"
        # based on the :count in the cart and the :num on the coupon. 
        if details[:count] >= coupon[:num]
          
          # We'll create a new hash
          clipped_cart[clipped_item] = {
            :price => coupon[:cost],
            :clearance => details[:clearance],
            :count => details[:count] / coupon[:num]
          }
          # In the event that we have a leftover, said item won't be discounted.
          # That leftover will get it's count based on the remainder of count, 
          # and the number the coupon takes(Modulo)
          remainder = details[:count] % coupon[:num]
        
          cart[item] = {
            :price => details[:price],
            :clearance => details[:clearance],
            :count => remainder
          }
               
        end
        
      end
        
    end
    
  end

  # if any coupons were applied
  if clipped_cart.length > 0
    cart.merge!(clipped_cart)
  else
    # if No coupons were applied
    cart
  end

end

def apply_clearance(cart)
  cart.map do |item, details|
    if details[:clearance] == true 
      new_price = details[:price] * 0.8
      details[:price] = new_price.round(2) 
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.map do |item, details|
    total += details[:price] * details[:count]
  end

  if total > 100 
    new_total = total * 0.9
    total = new_total.round(2) 
  end

  total
end
