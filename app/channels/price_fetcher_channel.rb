class PriceFetcherChannel < ApplicationCable::Channel
  # before_subscribe :connect

  def subscribed
    stream_from "price_fetcher_channel"
    stream_for current_user
    # current_user.appear
    # puts current_user_stocks_array

    # while true
    #   sleep(10)
    #   # send_data(User.first.stocks.first.ticker)
    #   ticker_array.each do |ticker|
    #     send_data(ticker)
    #   end
    # end
    # ActionCable.server.broadcast "price_fetcher_channel", {"ticker": send_data(current_user.stocks.first.ticker)}
    self.current_user.stocks.map{|stock| stock.ticker}.each do |ticker|
      send_data(ticker.to_s)
    end

    # ['TSLA', 'MSFT'].each do |ticker|
    #   send_data(ticker)
    # end
      
    
  end

  def send_data(ticker)
    client = IEX::Api::Client.new(
    publishable_token: Rails.application.credentials.iex_client[:publishable_token],
    secret_token: Rails.application.credentials.iex_client[:secret_token],
    endpoint: Rails.application.credentials.iex_client[:dev_endpoint])
    price = client.price(ticker)
    ActionCable.server.broadcast "price_fetcher_channel", {ticker: ticker, price: price}
  end

  # def current_user_stocks_array
  #   return current_user.stocks.map {|stock| stock.ticker}
  #   # User.first.stocks.map {|stock| stock.ticker}
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # ActionCable.server.broadcast "price_fetcher_channel", {"hello": "lost"}
  end
end
