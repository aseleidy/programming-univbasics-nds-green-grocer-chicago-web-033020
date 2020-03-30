require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  i = 0 
  while i < collection.length do 
    
    if name == collection[i][:item]
      return collection[i]
    end 
    
    i += 1 
  end 
  
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  consolidated_cart = []
  
  i = 0  
  
  while i < cart.length do 
    
    item = cart[i][:item]
    
    does_item_exist = find_item_by_name_in_collection(item, consolidated_cart)
    
    if does_item_exist != nil 
      cart[i][:count] += 1
    else 
      cart[i][:count] = 1 
      consolidated_cart << cart[i]
    end 
      
    i += 1
  end 
  
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  i = 0 
  
  while i < coupons.length do 
    item_with_coupon = find_item_by_name_in_collection(coupons[i][:item], cart)
    
    
    if  (item_with_coupon) && (coupons[i][:num] <= item_with_coupon[:count])
      new_object = {
        :item => "#{item_with_coupon[:item]} W/COUPON",
        :price =>  coupons[i][:cost]/coupons[i][:num],
        :clearance => item_with_coupon[:clearance],
        :count => coupons[i][:num] 
      }
      
      item_with_coupon[:count] -= coupons[i][:num] 
      
      cart << new_object
    end 
    
    i += 1
  end 
 
  cart
end

def apply_clearance(cart)
  new_cart = []
  i = 0 
  while i < cart.length do 
    item = cart[i] 
    if item[:clearance]
      item[:price] = (item[:price]*0.80).round(2)
      new_cart.push(item)
    end 
    
    i += 1 
  end 
   
  new_cart   
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * final_cart = consolidate_cart
  # * apply_coupons(final_cart)
  # * apply_clearance(final_cart)
  # final_cart
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
total = 0 
final_cart = []
  final_cart = consolidate_cart(cart)
  applied_coupons_cart = apply_coupons(cart, coupons)
  clearance_applied_cart = apply_clearance(final_cart)
  final_cart
   
  i = 0 
  while i < final_cart.length do
    j = 0 
    
    if final_cart[i][:count] > 1
        total += final_cart[i][:price] * final_cart_cart[i][:count]
    end 
    
    while j < applied_coupons_cart.length do 
      k = 0
        
        if final_cart[i][:item] != applied_coupons_cart[j][:item]
          total += final_cart[i][:price] * final_cart_cart[i][:count]
        end 
        
          while k < clearance_applied_cart.length do 
       
            total += clearance_applied_cart[k][:price] * clearance_applied_cart[k][:count]
        
            k += 1
          end 
      
        
      if final_cart[i][:item] == applied_coupons_cart[j][:item]
          
          total += applied_coupons_cart[j][:price] * applied_coupons_cart[j][:count]
      end 
      
      if applied_coupons_cart[j][:item] == final_cart[i][:item] + "W/COUPON"
          
          total += applied_coupons_cart[j][:price] * applied_coupons_cart[j][:count]    
      end 
      
      j += 1
    end
     
    i += 1 
  end 
 
  
  if total > 100
    total = total * 0.90
  end 
  
  total 
end
