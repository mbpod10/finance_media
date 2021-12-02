class PriceFetcherChannel < ApplicationCable::Channel  

  def subscribed
    stream_from "price_fetcher_channel"
    # stream_for current_user

    # while true
    #   sleep(3)
    #   current_user_ticker_array.each do |ticker|
    #     send_data(ticker)
    #   end
    # end
    
  end

  # def send_data(ticker) 
  #   price = client.price(ticker)
  #   ActionCable.server.broadcast "price_fetcher_channel", {ticker: ticker, price: price}
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # console.log(self.current_user.id)
    # connect.destroy
  end

  # private

  # def current_user_ticker_array 
  #   self.current_user.stocks.map{|stock| stock.ticker}
  # end

  # def client
  #   client = IEX::Api::Client.new(
  #   publishable_token: Rails.application.credentials.iex_client[:publishable_token],
  #   secret_token: Rails.application.credentials.iex_client[:secret_token],
  #   endpoint: Rails.application.credentials.iex_client[:dev_endpoint])
  # end
  
end
