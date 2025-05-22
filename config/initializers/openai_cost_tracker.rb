ActiveSupport::Notifications.subscribe('openai.request') do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  model  = event.payload[:model]
  tokens = event.payload[:tokens]
  Rails.logger.info("[OpenAI] #{model}  #{tokens} tokens  est.$#{tokens_cost(model, tokens)}")
end

def tokens_cost(model, tokens)
  rates = {
    'gpt-4.1-nano' => { in: 0.10, out: 0.40 },
    'gpt-4.1-mini' => { in: 0.40, out: 1.60 },
    'gpt-4.1' => { in: 2.00, out: 8.00 }
  }
  pair = rates[model]
  ((tokens[:prompt] * pair[:in] / 1_000_000.0) +
   (tokens[:completion] * pair[:out] / 1_000_000.0)).round(4)
end
