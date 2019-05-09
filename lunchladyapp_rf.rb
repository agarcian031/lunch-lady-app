# require "pry"

class MainDish  
  attr_accessor :name, :price 
  def initialize(name, price)
    @name = name 
    @price = price 
  end # end initialize 
end # end MainDish 

class SideDish < MainDish
end 

class LunchLady 
  def initialize 
    @main_dishes = [
      MainDish.new("Burger", 2.00),
      MainDish.new("Pizza", 2.50),
      MainDish.new("Enchiladas", 3.00)
    ]

    @side_dishes = [
      SideDish.new("Fries", 1.50),
      SideDish.new("Mash Potatoes", 1.00),
      SideDish.new("Bread Roll", 0.50)
    ]
    @cart_item = [] 
    @cart_price = [] 

    greeting 
  end #end def initialize 

  def greeting 
    puts "Welcome to DevPoint Lunch Room!" 
    puts "What is your name?"
    print "Enter name > "
    @user_name = gets.strip
    puts 
    begin 
    puts "What is the total amount you can spend today?"
    print "Enter amount > "
    @user_wallet = Float(gets.strip)
    rescue 
      puts 
      puts "Try again! Please enter a number:"
      puts 
      retry 
    end # end rescue 
    main_menu
  end  #end greeting

  def main_menu
    puts "\nHello, #{@user_name}. Please choose from the following options to continue with your order:\n"
    puts "1) Add a main dish"
    puts "2) Add a side dish"
    puts "3) View order and total"
    puts "4) Remove an item"
    puts "5) Proceed to checkout"
    puts "6) Clear your order"
    puts "7) Exit"
    print "Enter number > "
    choice = gets.strip.to_i 
    case choice 
    when 1 
      main_order
    when 2
      side_order
    when 3
      view_order #combined total order and total price
    when 4
      remove_item
    when 5
      purchase_item
    when 6
      remove_order
    when 7
      exit 
    else 
      puts 
      puts "Invalid Option"
      main_menu
    end #end case 
end #end main_menu

  

def main_order 
  puts "\nWhat would you like to order for your main dish?\n"
  puts "Choose from the following: "
  @main_dishes.each_with_index do |m, i|
    puts "#{i + 1})\n Main Dish: #{m.name}\n Price: $#{m.price}" 
  end #end main_dishes.each
  print "Enter number > "
  main_choice = gets.strip.to_i - 1 # gets user input 
  puts 
  puts "You chose #{@main_dishes[main_choice].name}" #prints back user choice
  @cart_item << @main_dishes[main_choice].name #pushes name into cart_item array 
  @cart_price << @main_dishes[main_choice].price #push price into cart_price array
  main_menu
end # end def order

def side_order
  puts 
  puts "What would you like to order for your side dish?" 
  puts "Choose from the following: "
  @side_dishes.each_with_index do |s, i|
    puts "#{i + 1})\n Side Dish: #{s.name}\n Price: $#{s.price}"  
  end # end do 
  print "Enter number > "
  side_choice = gets.strip.to_i - 1 # gets user input 
  puts 
  puts "You chose #{@side_dishes[side_choice].name}" #prints back user choice
  @cart_item << @side_dishes[side_choice].name #pushes name into cart_item array 
  @cart_price << @side_dishes[side_choice].price #push price into cart_price array 
  main_menu  
end #end side order 

def view_order 
  while @cart_item.empty?
    puts "\nYou have no items to view!\n"
    main_menu
  end #end while 
  puts "\nYour current order is:\n"
  @cart_item.each do |n|
    puts "#{n}"
  end # end do 
  @result = @cart_price.inject(0){|sum, x| sum + x}
  puts "\n Your current total is:\n"
  puts @result
  main_menu
end # end view_order 

def remove_item 
  while @cart_item.empty?
    puts "\nYou have no items to remove!\n"
    main_menu
  end 
  begin 
  puts 
  puts "Pick an item to remove:\n"
  @cart_item.each_with_index do |n, i|
    puts "#{i + 1}) #{n}"
end #end do 
  print "Enter number > "
  choice = Integer(gets.strip) 
rescue  
  puts 
  puts "Sorry! Enter a number!"
  retry 
end 
  puts "\nYou chose #{@cart_item[choice - 1]}"
  if choice > 0 && choice <= @cart_item.length 
    @cart_item.delete_at(choice - 1) # will delete item 
    @cart_price.delete_at(choice - 1) # will delete price
    @result = @cart_price.inject(0){|sum, x| sum + x}
    main_menu
  else 
    puts "Invalid Option\n"
    remove_item
  end #end if 
end # end remove_item 

def purchase_item
  while @cart_item.empty?
    puts "\nYou have no items to purchase!\n"
    main_menu
  end # end while
  if @result <= @user_wallet
    puts 
    puts "\nYour change is: $#{@user_wallet - @result}"
    puts "Thank you! Enjoy your meal, #{@user_name}!"
    exit 
  else 
    puts "\nInsufficient Funds. Please remove items or cancel order." 
      main_menu 
  end #end if 
end # end purchase 

def remove_order 
  if @cart_item.empty?
    puts "\nYou haven't ordered anything!\n"
    main_menu
  else
  @cart_item.clear 
  @cart_price.clear 
  puts "\nYour order has been removed.\n"
  main_menu
  end #if 
end #end remove_order/clear 

end #end LunchLady 

  # binding.pry 
  LunchLady.new 