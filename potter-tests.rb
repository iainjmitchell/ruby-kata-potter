require 'test/unit'

class TestPotterPricer < Test::Unit::TestCase
	def bookPrice
		8
	end

	def get_book_discounts
		BookDiscounts.new()
			.add(2, 0.95)
			.add(3, 0.90)
			.add(4, 0.80)
			.add(5, 0.75)
	end

	def test_0_book_total_equals_0
		basket = Basket.new()
		target = PotterPricer.new(bookPrice, get_book_discounts)
		assert_equal 0, target.price(basket)
	end

	def test_1_book_one_total_equals_8
		basket = Basket.new()
			.add_book(1)
		target = PotterPricer.new(bookPrice, get_book_discounts)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_two_total_equals_8
		basket = Basket.new()
			.add_book(2)
		target = PotterPricer.new(bookPrice, get_book_discounts)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_three_total_equals_8
		basket = Basket.new()
			.add_book(3)
		target = PotterPricer.new(bookPrice, get_book_discounts)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_four_total_equals_8
		basket = Basket.new()
			.add_book(4)
		target = PotterPricer.new(bookPrice, get_book_discounts)
		assert_equal bookPrice, target.price(basket)
	end

	def test_1_book_five_total_equals_8
		basket = Basket.new()
			.add_book(5)
		target = PotterPricer.new(bookPrice, get_book_discounts)
		assert_equal bookPrice, target.price(basket)
	end

	def test_2_same_books_total_equals_twice_price
		bookId = 1
		basket = Basket.new()
			.add_book(bookId)
			.add_book(bookId)
		target = PotterPricer.new(bookPrice, get_book_discounts)
		assert_equal bookPrice * 2, target.price(basket)
	end

	def test_2_different_books_total_equals_twice_price_minus_5_percent
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(2)
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal (bookPrice * 2) * book_discounts.get_discount_percentage_for(2), target.price(basket)
	end

	def test_3_different_books_total_equals_three_times_price_minus_10_percent
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(2)
			.add_book(3)
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal (bookPrice * 3) * book_discounts.get_discount_percentage_for(3), target.price(basket)
	end

	def test_4_different_books_total_equals_four_times_price_minus_10_percent
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(2)
			.add_book(3)
			.add_book(4)
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal (bookPrice * 4) * book_discounts.get_discount_percentage_for(4), target.price(basket)
	end

	def test_5_different_books_total_equals_four_times_price_minus_10_percent
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(2)
			.add_book(3)
			.add_book(4)
			.add_book(5)
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal (bookPrice * 5) * book_discounts.get_discount_percentage_for(5), target.price(basket)
	end

	def test_2_same_books_1_different_equals_1_book_plus_2_at_5_percent_discount
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(1)
			.add_book(2)			
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal bookPrice + (bookPrice * 2 * book_discounts.get_discount_percentage_for(2)), target.price(basket)
	end

	def test_2_sets_of_same_two_different_books
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(1)
			.add_book(2)			
			.add_book(2)
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal 2 * (bookPrice * 2 * book_discounts.get_discount_percentage_for(2)), target.price(basket)
	end

	def test_one_set_of_five_plus_one_single_book
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(2)
			.add_book(2)			
			.add_book(3)
			.add_book(4)
			.add_book(5)
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal bookPrice + (bookPrice * 5 * book_discounts.get_discount_percentage_for(5)), target.price(basket)
	end

	def test_that_two_sets_four_priotises_over_five_discount
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(1)
			.add_book(2)			
			.add_book(2)
			.add_book(3)
			.add_book(3)
			.add_book(4)
			.add_book(5)
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal 2 * (bookPrice * 4 * book_discounts.get_discount_percentage_for(4)), target.price(basket)
	end

	def test_big
		book_discounts = get_book_discounts()
		basket = Basket.new()
			.add_book(1)
			.add_book(1)
			.add_book(1)
			.add_book(1)
			.add_book(1)
			.add_book(2)
			.add_book(2)
			.add_book(2)
			.add_book(2)
			.add_book(2)
			.add_book(3)
			.add_book(3)
			.add_book(3)
			.add_book(3)
			.add_book(4)
			.add_book(4)
			.add_book(4)
			.add_book(4)
			.add_book(4)
			.add_book(5)
			.add_book(5)
			.add_book(5)
			.add_book(5)
		target = PotterPricer.new(bookPrice, book_discounts)
		assert_equal 3 * (bookPrice * 5 * book_discounts.get_discount_percentage_for(5)) + 
			2 * (bookPrice * 4 * book_discounts.get_discount_percentage_for(4)), target.price(basket)
	end
end

class PotterPricer
	def initialize(price, book_discounts)		
		price_calculator = NoDiscountPriceCalculator.new(price)
		discount_price_calculator = DiscountPriceCalculator.new(price_calculator, book_discounts)
		@discount_price_strategy = DiscountPriceStategy.new(price_calculator, discount_price_calculator)
	end

	def price(basket)
		return @discount_price_strategy.calculate(basket)
	end
end

class DiscountPriceCalculator
	def initialize(price_calculator, book_discounts)
		@price_calculator = price_calculator
		@book_discounts = book_discounts
	end

	def calculate(number_of_books)
		@price_calculator.calculate(number_of_books) * @book_discounts.get_discount_percentage_for(number_of_books)
	end
end

class NoDiscountPriceCalculator
	def initialize(price)
		@price = price
	end

	def calculate(number_of_books)
		number_of_books * @price
	end
end

class DiscountPriceStategy
	def initialize(price_calculator, discount_price_calculator)
		@price_calculator = price_calculator
		@discount_price_calculator = discount_price_calculator
	end

	def calculate(basket)
		return get_lowest_total(basket.books)
	end

	private

	def get_total(books, book_quantity)
		book_set = books.uniq
		if (book_set.length > book_quantity)
			book_set = book_set.take(book_quantity)
		end
		total = @discount_price_calculator.calculate(book_set.length)

		remaining_books = get_remaining_books(books, book_set)
		return total + @price_calculator.calculate(remaining_books.length) if (remaining_books.length <= 1)
		return total + get_lowest_total(remaining_books)
	end

	def get_lowest_total(remaining_books)
		lowest_next_total = nil
		for discount_quantity in 2..5
			current_next_total = get_total(remaining_books, discount_quantity)
			lowest_next_total = current_next_total if (lowest_next_total == nil) || (lowest_next_total > current_next_total)
		end
		return lowest_next_total
	end

	def get_remaining_books(books, book_set)
		remaining_books = Array.new(books)
		book_set.each do |bookId|
			remaining_books.delete_at(remaining_books.index(bookId))
		end
		return remaining_books
	end
end

class BookDiscounts
	def initialize()
		@discount_amounts = Hash.new()
	end

	def add(number_of_unique_books, discount_amount)
		@discount_amounts[number_of_unique_books] = discount_amount
		self
	end

	def get_discount_percentage_for(number_of_unique_books)
		@discount_amounts.include?(number_of_unique_books) ? @discount_amounts[number_of_unique_books] : 1
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

	def remove_book(bookId)
		@books.delete_at(@books.index(bookId))
	end

	def number_of_books()
		@books.length
	end
end