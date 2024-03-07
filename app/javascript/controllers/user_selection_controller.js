import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-selection"
export default class extends Controller {
  static targets = ["div"]

  toggleStyle(event){
    // event.preventDefault()
    // this.divTargets.forEach(div => {
    //   div.classList.remove("border-2",  "border-gray-200", "bg-sky-200");
    // });
    // this.element.classList.add("border-2", "border-gray-200", "bg-sky-200");
  }
}
