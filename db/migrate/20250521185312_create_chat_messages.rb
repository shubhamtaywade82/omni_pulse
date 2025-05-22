# frozen_string_literal: true

class CreateChatMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_messages do |t|
      t.string :role
      t.text :content
      t.references :conversation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
