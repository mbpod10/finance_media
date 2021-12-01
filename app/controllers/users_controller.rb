class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def friend_search
    puts User.search(params[:friend])
  end

end
