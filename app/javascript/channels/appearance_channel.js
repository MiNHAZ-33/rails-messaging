import consumer from "channels/consumer"

consumer.subscriptions.create("AppearanceChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    // const home = document.getElementById("main")
    // console.log("Connected the consumer")
    // if( !home){
    //   console.log("Should log out now")
    //   this.perform("offline")
    // }
    console.log("Connected the consumer")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});
