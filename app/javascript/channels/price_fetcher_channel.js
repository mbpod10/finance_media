import consumer from "./consumer"
let dollarUSLocale = Intl.NumberFormat('en-US');

consumer.subscriptions.create("PriceFetcherChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    $(`#${data.ticker}`).text((`$${dollarUSLocale.format(data.price)}`))
  }
});
