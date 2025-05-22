# frozen_string_literal: true

class ChatMessage < ApplicationRecord
  belongs_to :conversation
  enum :role, { user: 'user', assistant: 'assistant', system: 'system' }
  validates :content, presence: true
  after_create_commit -> { broadcast_append_to conversation }
end
