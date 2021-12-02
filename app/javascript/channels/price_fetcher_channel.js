import consumer from "./consumer"
let dollarUSLocale = Intl.NumberFormat('en-US');

consumer.subscriptions.create("PriceFetcherChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected To Server")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected To Server")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data)
    $(`#${data.ticker}`).text((`$${dollarUSLocale.format(data.price)}`))
    $(`#${data.ticker}`).css("color", data.color)
  }
});
