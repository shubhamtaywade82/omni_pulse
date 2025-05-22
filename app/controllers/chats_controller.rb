# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_conversation

  def index
    @chat_messages = @conversation.chat_messages.order(:created_at)
  end

  def create
    # 1. store user message
    @conversation.chat_messages.create!(role: :user, content: chat_params[:content])

    # 2. kick async job with routing context
    ctx = RequestContext.new(
      prompt: chat_params[:content],
      headers: request.headers,
      params: safe_context_params # ← only permitted keys
    )
    OpenaiChatJob.perform_later(@conversation.id, ctx.to_h) # serialize as hash

    respond_to { |f| f.turbo_stream }
  end

  private

  def set_conversation
    @conversation = Conversation.first_or_create!(title: 'Default')
  end

  def chat_params
    params.expect(chat_message: [:content])
  end

  def safe_context_params
    params.permit(:deep_reason).to_h
  end
end
