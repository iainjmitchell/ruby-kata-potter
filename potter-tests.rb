require 'test/unit'

class TestPotterPricer < Test::Unit::TestCase
	def bookPrice
		8
	end

	def test_0_book_total_equals_0
		basket = Basket.new()
		target = PotterPricer.new(bookPrice, 0.95)
		assert_equal 0, target.price(basket)
	end

	def test_1_book_one_total_equals_8
		basket = Basket.new()
			.add_book(1)
		target = PotterPricer.new(bookPrice, 0.95)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_two_total_equals_8
		basket = Basket.new()
			.add_book(2)
		target = PotterPricer.new(bookPrice, 0.95)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_three_total_equals_8
		basket = Basket.new()
			.add_book(3)
		target = PotterPricer.new(bookPrice, 0.95)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_four_total_equals_8
		basket = Basket.new()
			.add_book(4)
		target = PotterPricer.new(bookPrice, 0.95)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_five_total_equals_8
		basket = Basket.new()
			.add_book(5)
		target = PotterPricer.new(bookPrice, 0.95)
		assert_equal bookPrice, target.price(basket)
	end

	def test_2_same_books_total_equals_twice_price
		bookId = 1
		basket = Basket.new()
			.add_book(bookId)
			.add_book(bookId)
		target = PotterPricer.new(bookPrice, 0.95)
		assert_equal bookPrice * 2, target.price(basket)
	end

	def test_2_different_books_total_equals_twice_price_minus_5_percent
		discount_percentage = 0.95
		basket = Basket.new()
			.add_book(1)
			.add_book(2)
		target = PotterPricer.new(bookPrice, discount_percentage)
		assert_equal (bookPrice * 2) * discount_percentage, target.price(basket)
	end

	def test_another_2_different_books_total_equals_twice_price_minus_5_percent
		discount_percentage = 0.95
		basket = Basket.new()
			.add_book(3)
			.add_book(4)
		target = PotterPricer.new(bookPrice, discount_percentage)
		assert_equal (bookPrice * 2) * discount_percentage, target.price(basket)
	end
end

class PotterPricer
	def initialize(price, discount_percent)
		@price = price
		@discount_percent = discount_percent
	end

	def price(basket)
		return basket.books.length * @price  * @discount_percent  if contains_discount?(basket)
		return basket.books.length * @price
	end

	private 

	def contains_discount?(basket)
		basket.books.uniq.length == 2
	end
end

class Basket
	attr_reader :books

	def initialize()
		@books = []
	end

	def add_book(bookId)
		@books.push(bookId)
		self
	end
end

