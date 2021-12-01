class FriendshipsController < ApplicationController
  
  def friends_list
    @friends = current_user.friends    
  end

 
end