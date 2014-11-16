class CartsController < ApplicationController
  helper_method :item_num

  def index	
  
  end

  def show
	  @cookie = cookies[:zhaitx_id]
  end
  
  def add
    @item_id = params[:item_id]
    if $redis.hexists current_user_cart,@item_id
    	item_num = $redis.hget current_user_cart,@item_id
    	@item_num = item_num.to_i + 1
    	 $redis.hset current_user_cart,@item_id,@item_num.to_s
    else
	    $redis.hset current_user_cart,@item_id,"1"
	  end

		item_ids = $redis.hkeys current_user_cart
		@cart_items = Item.find(item_ids)

  	respond_to do |format|
			format.html {redirect_to items_path}	
  		format.js 	
  	end
  end

  def remove

  end
  
	def item_num(item)
		$redis.hget current_user_cart,item.id.to_s
	end
  
  private
  
  def current_user_cart
    cookie = cookies[:zhaitx_id]
    "cart#{cookie}"
  end
end
