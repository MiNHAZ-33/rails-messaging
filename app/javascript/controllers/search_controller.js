import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["inputField", "outputField"];
  typingTimer;

  async typed() {

    clearTimeout(this.typingTimer);

    const inputFieldValue = this.inputFieldTarget.value;
    if(inputFieldValue === ""){
      this.displayResults(null)
      return
    }

    this.typingTimer = setTimeout(async()=>{
      try {
        const searchResults = await this.searchInBackend(inputFieldValue);
        this.displayResults(searchResults);
      } catch (error) {
        console.error('Error searching:', error);
        this.outputFieldTarget.innerHTML = "<p>Error searching. Please try again.</p>";
      }
    }, 500)
  }

  async searchInBackend(query) {
    const response = await fetch(`/search/users/${query}`);
    const searchData = await response.json();
    console.log(searchData); // Log the actual JSON data
    return searchData;
  }

  displayResults(results) {
    if (results === null){
      this.outputFieldTarget.hidden = true
    } else {
      this.outputFieldTarget.hidden = false
      if(results.length === 0){
        this.outputFieldTarget.innerHTML = `<ul class="w-full bg-white px-2 py-2 ">No match found</ul>`;
        return
      }
      const resultList = results.map(result => `<li class="bg-white px-2 border-b-2 py-4 w-full"><a href="/users/${result.id}"> ${result.username}</a></li>`).join("");
      this.outputFieldTarget.innerHTML = `<ul class="w-full bg-white">${resultList}</ul>`;
    }
  }
}
