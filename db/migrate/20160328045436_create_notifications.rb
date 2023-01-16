# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.bigint :user_id, null: false
      t.bigint :actor_id
      t.string :notify_type, null: false
      t.string :target_type
      t.bigint :target_id
      t.string :second_target_type
      t.bigint :second_target_id
      t.string :third_target_type
      t.bigint :third_target_id
      t.boolean :is_opened, default: false
      t.datetime :opened_at
      t.string :redirect_url
      t.integer :actor_count, default: 1
      t.boolean :is_email, default: false
      t.boolean :is_sent, default: false
      t.boolean :is_desktop, default: true

      t.timestamps null: false
    end

    add_index :notifications, %i[user_id notify_type]
    add_index :notifications, [:user_id]
    add_index :notifications, [:user_id, :is_opened, :is_desktop]
    add_index :notifications, [:second_target_id, :second_target_type]
    add_index :notifications, [:target_id, :target_type]
  end
end
