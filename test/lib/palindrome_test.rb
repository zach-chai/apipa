require 'test_helper'

PALINDROME_CASES = [[true, 'apipa'],
                    [true, 'aba'],
                    [false, 'ab'],
                    [false, 'aA'],
                    [true, 'z'],
                    [true, '121'],
                    [false, ''],
                    [true, 'deed'],
                    [false, true],
                    [false, 1221]]

class PalindromeTest < ApplicationTest
  def test_palindrome
    PALINDROME_CASES.each do |palindrome_case|
      verify_palindrome(*palindrome_case)
    end
  end

  def verify_palindrome expected, input
    assert_equal expected, Palindrome.palindrome?(input), "Expected '#{input}' to return #{expected}"
  end
end
