require 'test/unit'

class TestPotterPricer < Test::Unit::TestCase
	def bookPrice
		8
	end

	def test_0_book_total_equals_0
		basket = Basket.new()
		target = PotterPricer.new(bookPrice)
		assert_equal 0, target.price(basket)
	end

	def test_1_book_one_total_equals_8
		basket = Basket.new()
			.add_book(1)
		target = PotterPricer.new(bookPrice)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_two_total_equals_8
		basket = Basket.new()
			.add_book(2)
		target = PotterPricer.new(bookPrice)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_three_total_equals_8
		basket = Basket.new()
			.add_book(3)
		target = PotterPricer.new(bookPrice)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_four_total_equals_8
		basket = Basket.new()
			.add_book(4)
		target = PotterPricer.new(bookPrice)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_five_total_equals_8
		basket = Basket.new()
			.add_book(5)
		target = PotterPricer.new(bookPrice)
		assert_equal bookPrice, target.price(basket)
	end

	def test_2_same_books_total_equals_twice_price
		bookId = 1
		basket = Basket.new()
			.add_book(bookId)
			.add_book(bookId)
		target = PotterPricer.new(bookPrice)
		assert_equal bookPrice * 2, target.price(basket)
	end
end

class PotterPricer
	def initialize(price)
		@price = price
	end

	def price(basket)
		return basket.get_number_books() * @price
	end
end

class Basket
	def initialize()
		@bookCount = 0
	end

	def add_book(bookId)
		@bookCount += 1 
		self
	end

	def get_number_books()
		@bookCount
	end
end

