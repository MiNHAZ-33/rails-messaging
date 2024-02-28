import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    const scroller_id = document.getElementById("scroller_id");
      scroller_id.addEventListener("DOMNodeInserted", this.resetScroll);
    this.resetScroll(scroller_id)
  }
  disconnect(){
  }
  resetScroll(){
      scroller_id.scrollTop = scroller_id.scrollHeight - scroller_id.clientHeight
  }
}
