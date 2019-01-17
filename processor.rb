require('./scramble_pair.rb')

input_list = File.readlines(ARGV[0])

input_list.each do |text_pair|
  #puts text_pair
  text_elements = text_pair.split(" ")
  scramble_pair = ScramblePair.new(text_elements.first,text_elements.last)
  scramble_pair.check_scramble_quality
end
