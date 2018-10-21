module Palindrome
  def palindrome? string
    return false if !string.is_a?(String) || string.empty?

    left = 0
    right = string.length - 1

    while left < right
      if string[left] != string[right]
        return false
      end
      left += 1
      right -= 1
    end

    true
  end
  module_function :palindrome?
end
