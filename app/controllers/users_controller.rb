class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
    current_user.stocks.map {|stock| stock.ticker}.each do |ticker|
        puts ticker.to_s
      end
  end


  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)

      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' } 
        end        
      else
        respond_to do |format|         
          flash.now[:alert] = "Couldn't Find User"
          format.js { render partial: 'users/friend_result' } 
        end      
      end

    else
      respond_to do |format|         
        flash.now[:alert] = "Please Enter A Name Or Email To Search"
        format.js { render partial: 'users/friend_result' } 
      end    

    end
  end


end
