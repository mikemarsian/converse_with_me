# models
class User < ActiveRecord::Base
  has_and_belongs_to_many :events
end

class Event
  has_and_belongs_to_many :users
end

#migrations
class CreateTables < ActiveRecord::Migration
  def self.up
    create_table(:users) { |t| t.string :name; t.string :email }
    create_table(:events) { |t| t.string :title; t.datetime :starts_at }
    create_table(:event_users) { |t| t.integer :user_id; t.integer :event_id }
  end
end

ActiveRecord::Migration.verbose = false
CreateTables.up