import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["inputField", "outputField"];

  connect() {
    console.log("Search is connected");
  }

  async typed() {
    const inputFieldValue = this.inputFieldTarget.value;
    if(inputFieldValue === ""){
      this.displayResults(null)
      return
    }
    try {
      const searchResults = await this.searchInBackend(inputFieldValue);
      this.displayResults(searchResults);
    } catch (error) {
      console.error('Error searching:', error);
      this.outputFieldTarget.innerHTML = "<p>Error searching. Please try again.</p>";
    }
  }

  async searchInBackend(query) {
    const response = await fetch(`/search/users/${query}`);
    const searchData = await response.json();
    console.log(searchData); // Log the actual JSON data
    return searchData;
  }

  displayResults(results) {
    if (results === null){
      return
    } else {
      const resultList = results.map(result => `<li>${result.username}</li>`).join("");
      this.outputFieldTarget.innerHTML = `<ul>${resultList}</ul>`;
    }
  }
}
