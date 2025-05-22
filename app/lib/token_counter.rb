require "tiktoken_ruby"

class TokenCounter
  ENCODER = Tiktoken.encoding_for_model("gpt-4.1-nano")

  def self.count(text)
    ENCODER.encode(text).length
  rescue StandardError
    # fallback: 4-char heuristic
    (text.size / 4.0).ceil
  end
end