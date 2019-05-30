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

# def apply_coupons(cart, coupons)
#   #subtract coupons[num] from cart[count]
#   #create new key value pair |item w/ coupon|[:count]=result
#   #=---------------------------------------------------------#
#   #iterate through cart/ grab count
#     #iterate though coupons/ grab num
#       #subtract num from coupons
#       #save result into a variable
# count = nil
# num = nil
#   cart.each do |key, value|
#     value.each do |key, value|
#       if key == :count
#         count = value
#         coupons.each do |info|
#           info.each do |key, value|
#             if key == :num
#               num = value
#             end
#           end
#         end
#       end
#     end
#   end
#   binding.pry
# end


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
count = nil
num = nil
newhash = {}

cart.each do |key, value|
  
  newhash[key] = value
  coupons.each do |info|
    
    info.each do |k, v|
      
      if key == v && cart[key][:count] >= info[:num]
        count = cart[key][:count]
        num = info[:num]

        newhash["#{key} W/COUPON"] = {}
        newhash["#{key} W/COUPON"][:price] = info[:cost]
        newhash["#{key} W/COUPON"][:clearance] = cart[key][:clearance]
        newhash["#{key} W/COUPON"][:count] = 1
        newhash[key][:count] = count - num
        # binding.pry
      end
    end
  end
end
newhash.each do |key, value|

binding.pry
end
return newhash
end


# cart["#{newkey} W/COUPON"]
  # cart.each do |key, value|
  #   value.each do |key, value|
  #     if key == :count
  #       count = value
  #       coupons.each do |info|
  #         info.each do |key, value|
  #           if key == :num
  #             num = value
  #           end
  #         end
  #       end
  #     end
  #   end
  # end
  # binding.pry

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
