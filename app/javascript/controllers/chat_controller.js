import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect () {
    // Always scroll to bottom on first load
    this.scrollToBottom()
  }
  // Called by Turbo after each streamed morph
  scrollToBottom () {
    this.element.scrollTop = this.element.scrollHeight
  }

  // Receive broadcast from Rails when new message arrives
  received () {
    this.scrollToBottom()
  }
}
