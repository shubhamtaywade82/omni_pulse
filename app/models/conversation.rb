# frozen_string_literal: true

class Conversation < ApplicationRecord
  has_many :chat_messages, dependent: :destroy
  validates :title, presence: true
end
