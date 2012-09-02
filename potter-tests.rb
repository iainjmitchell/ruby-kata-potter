require 'test/unit'

class TestPotterPricer < Test::Unit::TestCase
	def test_0_book_total_equals_0
		target = PotterPricer.new()
		assert_equal 0, target.price([])
	end

	def test_1_book_one_total_equals_8
		target = PotterPricer.new()
		assert_equal 8, target.price([1])
	end

	def test_1_book_two_total_equals_8
		target = PotterPricer.new()
		assert_equal 8, target.price([2])
	end

	def test_1_book_three_total_equals_8
		target = PotterPricer.new()
		assert_equal 8, target.price([3])
	end

	def test_1_book_four_total_equals_8
		target = PotterPricer.new()
		assert_equal 8, target.price([4])
	end

	def test_1_book_five_total_equals_8
		target = PotterPricer.new()
		assert_equal 8, target.price([5])
	end
end

class PotterPricer
	def price(basket)
		basket.length == 0 ? 0 : 8
	end
end