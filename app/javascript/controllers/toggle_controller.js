import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["menu"]

  static values = { isOpen: {type: Boolean, default: false}}

  menu(){
    this.isOpenValue ?  this.hide() : this.show()
    this.isOpenValue = !this.isOpenValue
  }

  show(){
    this.menuTarget.style.display = "block"
  }
  hide(){
    this.menuTarget.style.display = "none"
  }

}
