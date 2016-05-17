require "test/unit"

# This class mimics Ruby's flatten method which takes an array and returns a one level array flattened
# The tests check for the right length and content

class Array
  def make_flat
    each_with_object([]) do |element, flattened|
      flattened.push *(element.is_a?(Array) ? element.make_flat : element)
    end
  end
end

class TestMakeFlat < Test::Unit::TestCase

  def init
    @arr1 = [[1,2,[3]],4]
    @arr2 = [1,2,3,4,[1,2,3,4],5]
    @arr3 = [1,2,3,4,[7,9,8,[6]],5, [10]]
  end

  def test_length
    init
    flat_arr = @arr1
    assert_equal(4, flat_arr.make_flat.length)
    flat_arr = @arr2
    assert_equal(9, flat_arr.make_flat.length)
    flat_arr = @arr3
    assert_equal(10, flat_arr.make_flat.length)
  end

  def test_content
    init
    assert_equal([1,2,3,4].sort, @arr1.make_flat.sort)
    assert_equal([1, 1, 2, 2, 3, 3, 4, 4, 5].sort, @arr2.make_flat.sort)
    assert_equal([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].sort, @arr3.make_flat.sort)
    assert_equal([10, 9, 8, 7, 6, 5, 4, 1, 2, 3].sort, @arr3.make_flat.sort)
  end

end