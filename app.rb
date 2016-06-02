require_relative 'basket'

b = Basket.new
ARGV.each {|item| b.scan item}
p b.total