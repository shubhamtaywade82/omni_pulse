import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea"]

  autoResize (e) {
    const ta = e.target
    ta.style.height = "auto"
    ta.style.height = ta.scrollHeight + "px"
  }

  reset () {
    // clear & shrink textarea after form succeeds
    this.element.reset()
    this.element.querySelector("textarea").style.height = "auto"
  }
}
