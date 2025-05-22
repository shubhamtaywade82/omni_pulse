class OpenaiChatService
  def initialize(conversation, context)
    @conversation = conversation
    @context      = context
    @client       = HTTPX.with(headers: { 'Authorization' => "Bearer #{ENV.fetch('OPENAI_API_KEY', nil)}" })
  end

  def call
    chosen_model = LlmRouter.new(@context).model

    body = {
      model: chosen_model,
      stream: true,
      messages: @conversation.chat_messages.order(:created_at)
                             .map { |m| { role: m.role, content: m.content } }
    }

    @client.post('https://api.openai.com/v1/chat/completions', json: body)
  end
end
