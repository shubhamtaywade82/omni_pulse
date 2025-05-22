# frozen_string_literal: true

module Api
  module V1
    class ChatController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        conversation = Conversation.find_or_create_by(id: params[:conversation_id]) { |c| c.title = 'API' }
        message      = conversation.chat_messages.create!(role: :user, content: params[:content])

        OpenaiChatJob.perform_later(conversation.id)

        render json: { status: 'queued', message_id: message.id }, status: :accepted
      end
    end
  end
end
