def consolidate_cart(cart)
  hash=Hash.new(0)
  result={}
  cart.each do |items_hash|
    items_hash.each do |k,v|
      hash[k]+=1
    end
  end
    
  cart.each do |items_hash|
    items_hash.each do |k,v|
      items_hash[k][:count]=hash[k]
    end
  end
cart.each do |hash|
hash.each do |k,v|
result[k]=v
end
end
cart=result
end

def apply_coupons(cart, coupons)
 result=cart
 temp={}
 key=""
 coupons.each do |coupon_hash|
  name=coupon_hash[:item]
  if !result[name].nil? && result[name][:count] >= coupon_hash[:num]
    key=name+" W/COUPON"
    temp[key]={
      price: coupon_hash[:cost],
      clearance: result[name][:clearance],
      count: 1}
      

      if result[key].nil?
        result.merge!(temp)
      else
        result[key][:count]+=1
      end
      result[name][:count]-=coupon_hash[:num]
    end
 end
 result
end

def apply_clearance(cart)
  cart.each do |item,hash|
    if hash[:clearance]
      hash[:price]=(0.8*hash[:price]).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart=consolidate_cart(cart)
 if !coupons.nil? && !cart.nil?
  cart=apply_coupons(cart,coupons)
 end
  clearence_applied=apply_clearance(cart)
  total=0
  cart.each do |item,hash|
    total+=hash[:price] * hash[:count]
  end
if total >100
  total=(total*0.9).round(2)
end
total
end


