class Message < Ohm::Model
  attribute :message
  attribute :palindrome

  def to_json
    { message: message, palindrome: palindrome }
  end
end
