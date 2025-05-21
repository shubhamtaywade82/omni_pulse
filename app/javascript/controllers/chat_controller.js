import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.scrollIntoView({ behavior: "smooth", block: "end" })
  }
  clear(e) {
    if (e.detail.success) {
      this.element.reset()
    }
  }
}