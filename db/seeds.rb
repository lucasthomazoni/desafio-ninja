# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Room.create(
  [
    { name: 'Room 1' },
    { name: 'Room 2' },
    { name: 'Room 3' },
    { name: 'Room 4' }
  ]
)

User.create(
  [
    { name: 'User 1' },
    { name: 'User 2' },
    { name: 'User 3' },
    { name: 'User 4' },
    { name: 'User 5' },
    { name: 'User 6' },
    { name: 'User 7' },
    { name: 'User 8' },
    { name: 'User 9' }
  ]
)
