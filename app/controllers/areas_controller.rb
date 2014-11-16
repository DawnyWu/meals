class AreasController < ApplicationController
  def index
  	if cookies[:zhaitx_id].present?
  	  @cookie = cookies[:zhaitx_id]
  	else
 	  	cookies.permanent[:zhaitx_id] =  SecureRandom.uuid
  	end
  	# cookies[:zhaitx_id]=nil
  end

  private

end
