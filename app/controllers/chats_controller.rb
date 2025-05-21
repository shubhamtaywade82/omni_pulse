# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_conversation

  def index
    @chat_messages = @conversation.chat_messages.order(:created_at)
  end

  def create
    @chat_messages = @conversation.chat_messages
    @chat_messages.create!(chat_params.merge(role: :user))

    # Kick off async streaming job (Step 4 will add OpenAI logic)
    OpenaiChatJob.perform_later(@conversation.id)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_conversation
    @conversation = Conversation.first_or_create!(title: "Default")
  end

  def chat_params
    params.require(:chat_message).permit(:content)
  end
end
