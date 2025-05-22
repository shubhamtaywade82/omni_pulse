# frozen_string_literal: true

class OpenaiChatService
  MODEL = 'gpt-4o-mini' # or your preferred model

  def initialize(conversation)
    @conversation = conversation
    @client = HTTPX.plugin(:retries).with(headers: {
                                            'Authorization' => "Bearer #{ENV.fetch('OPENAI_API_KEY')}",
                                            'OpenAI-Organization' => ENV.fetch('OPENAI_ORG_ID', nil)
                                          })
  end

  def call
    payload = {
      model: MODEL,
      stream: true,
      messages: @conversation.chat_messages.order(:created_at).map do |m|
        { role: m.role, content: m.content }
      end
    }
    @client.post('https://api.openai.com/v1/chat/completions', json: payload)
  end
end
