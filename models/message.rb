class Message < Ohm::Model
  attribute :content
  attribute :is_palindrome
  index :is_palindrome
end
