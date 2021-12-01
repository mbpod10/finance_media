class FriendshipsController < ApplicationController
  
  def friends_list
    @friends = current_user.friends    
  end

  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "#{friend.full_name} Added To Your Friends"
      # redirect_to friends_list_path(current_user)
    else 
      flash[:alert] = "There was something wrong"
    end  
    redirect_to friends_list_path(current_user)
  end

  def destroy    
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "User Deleted From Your Friends"
    redirect_to friends_list_path(current_user)  
  end
 
end