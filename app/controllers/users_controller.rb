class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
    
    # @tracked_stocks.each do |stock|
    #   get_price(stock)
    # end
    ActionCable.server.broadcast "price_fetcher_channel", {data: get_prices(@tracked_stocks)}
    # ActionCable.server.broadcast "price_fetcher_channel", {ticker: stock.ticker, price: new_price, color: color}
  end
  
  # def portfolio_refresh
  #   @tracked_stocks = current_user.stocks
  #   @user = current_user
  #   ActionCable.server.broadcast "price_fetcher_channel", {data: get_prices(@tracked_stocks)}

  # end


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

  private

  def get_prices(stocks)
    return_obj = []
    stocks.each do |stock|
      old_price = stock.last_price
      new_price = client.price(stock.ticker)
      color = stock.last_price < new_price ? "green" : "red"
      stock[:last_price] = new_price
      stock.save

      stock_object = {
        "ticker": stock.ticker,
        "price":  new_price,
        "color": color
      }
      return_obj.push(stock_object)
    end
    return_obj
  end
  
  def current_user_ticker_array 
    current_user.stocks.map{|stock| stock.ticker}
  end

  def client
    client = IEX::Api::Client.new(
    publishable_token: Rails.application.credentials.iex_client[:publishable_token],
    secret_token: Rails.application.credentials.iex_client[:secret_token],
    endpoint: Rails.application.credentials.iex_client[:dev_endpoint])
  end

end
