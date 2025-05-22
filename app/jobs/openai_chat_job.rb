# app/jobs/openai_chat_job.rb
class OpenaiChatJob < ApplicationJob
  queue_as :default

  # context_hash is the RequestContext#to_h we passed in
  def perform(conversation_id, context_hash)
    conversation = Conversation.find(conversation_id)
    context      = RequestContext.new(**context_hash.symbolize_keys)

    stream = OpenaiChatService.new(conversation, context).call

    assistant_msg = conversation.chat_messages.create!(role: :assistant, content: '')
    buffer = +''

    stream.body.each do |raw|
      chunk = JSON.parse(raw)
      delta = chunk.dig('choices', 0, 'delta', 'content') || ''
      buffer << delta
      ChatChannel.broadcast_to(conversation, { id: assistant_msg.id, append: delta })
    end

    assistant_msg.update!(content: buffer)
  end
end
