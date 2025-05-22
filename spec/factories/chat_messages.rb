# frozen_string_literal: true

FactoryBot.define do
  factory :chat_message do
    role { 'MyString' }
    content { 'MyText' }
    conversation { nil }
  end
end
