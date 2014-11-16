module ApplicationHelper

  def current_user_cart
    cookie = cookies[:zhaitx_id]
    "cart#{cookie}"
  end

  # 购买商品的数量
	def item_num(item)
		$redis.hget current_user_cart,item.id.to_s
	end
  
  # 返回购物车中的商品数组
	def cart_items
		item_ids = $redis.hkeys current_user_cart
		Item.find(item_ids)
	end

	def cart_count
		array = $redis.hvals current_user_cart
		cart_quantity = array.map(&:to_f).inject(:+).to_i
	end

	def cart_sum
		hash = $redis.hgetall current_user_cart
	  sum = 0
	  hash.each do |h,v|
	   	sum = (Item.find(h).price)*(v.to_f)+sum
	  end
	  sum.round(2)
	end
end
