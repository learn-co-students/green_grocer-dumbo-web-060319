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

# let(:items) do
#   [
#     {"AVOCADO" => {:price => 3.00, :clearance => true}},
#     {"KALE" => {:price => 3.00, :clearance => false}},
#     {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
#     {"ALMONDS" => {:price => 9.00, :clearance => false}},
#     {"TEMPEH" => {:price => 3.00, :clearance => true}},
#     {"CHEESE" => {:price => 6.50, :clearance => false}},
#     {"BEER" => {:price => 13.00, :clearance => false}},
#     {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
#     {"BEETS" => {:price => 2.50, :clearance => false}},
#     {"SOY MILK" => {:price => 4.50, :clearance => true}}
#   ]
# end

# let(:coupons) do
#   [
#     {:item => "AVOCADO", :num => 2, :cost => 5.00},
#     {:item => "BEER", :num => 2, :cost => 20.00},
#     {:item => "CHEESE", :num => 3, :cost => 15.00}
#   ]
# end

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
  # binding.pry
  consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  binding.pry
end

# * Apply coupon discounts if the proper number of items are present.

# * Apply 20% discount if items are on clearance.

# * If, after applying the coupon discounts and the clearance discounts, the cart's total is over $100, then apply a 10% discount.

# ### Named Parameters

# The method signature for the checkout method is
# `consolidate_cart(cart:[])`. This, along with the checkout method uses a ruby 2.0 feature called [Named Parameters](http://brainspec.com/blog/2012/10/08/keyword-arguments-ruby-2-0/).

# Named parameters give you more expressive code since you are specifying what each parameter is for. Another benefit is the order you pass your parameters doesn't matter!
# `checkout(cart: [], coupons: [])` is the same as `checkout(coupons: [], cart: [])`
