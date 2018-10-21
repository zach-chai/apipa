class Message < Ohm::Model
  attribute :content
  attribute :is_palindrome
  index :is_palindrome

  SORT_ATTRIBUTES = ['id', 'is_palindrome']
end
