require "pry"

#how to store it? 

class MainDish  
  attr_accessor :name, :price 
  def initialize(name, price)
    @name = name 
    @price = price 
  end 
 
end 

class SideDish < MainDish
  # attr_accessor :name, :price 
  # def initialize(name, price)
  #   @name = name 
  #   @price = price 
  # end 
end 

class LunchLady
  # attr_accessor :main_dishes, :side_dishes, :cart, :user_name, :user_wallet
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
    

    # APP ORDER - METHOD CALLS 
    greeting
    # main_order
    # side_order
    # extra_options
    # total_order
    # total_price
    # purchase_options
  end # end initialize 

  def greeting 
    puts "Welcome to DevPoint Lunch Room!" 
    puts "What is your name?"
    print "Enter name > "
    @user_name = gets.strip
    puts "What is the total amount you can spend today?"
    print "Enter amount > "
    @user_wallet = gets.to_f 
    main_order
  end 


  def main_order 
    puts "Hello, #{@user_name}, what would you like to order for your main dish? "
    puts "Choose from the following: "
    # @main_dishes.each_with_index do |m, i|
    #   puts "#{i + 1})\n Main Dish: #{m[:name]}\n Price: #{m[:price]}"
    # end 
    @main_dishes.each_with_index do |m, i|
      puts "#{i + 1})\n Main Dish: #{m.name}\n Price: $#{m.price}" 
    end #end main_dishes.each
    main_choice = gets.strip.to_i - 1 # gets user input 
    puts "You chose #{@main_dishes[main_choice].name}" #prints back user choice
    @cart_item << @main_dishes[main_choice].name #pushes name into cart_item array 
    @cart_price << @main_dishes[main_choice].price #push price into cart_price array
    extra_options
  end # end def order


  def side_order
    puts "What would you like to order for your side dish?" 
    puts "Choose from the following: "
    @side_dishes.each_with_index do |s, i|
      puts "#{i + 1})\n Side Dish: #{s.name}\n Price: $#{s.price}"  
    end # end do 
    side_choice = gets.strip.to_i - 1 # gets user input 
    puts "You chose #{@side_dishes[side_choice].name}" #prints back user choice
    @cart_item << @side_dishes[side_choice].name #pushes name into cart_item array 
    @cart_price << @side_dishes[side_choice].price #push price into cart_price array 
    extra_options   
  end #end side order 

    # TO DO: Add would you like to add a side? 
  def extra_options 
    puts "Add a main, add a side, or proceed to checkout?"
    puts "1) Add a main"
    puts "2) Add a side"
    puts "3) Checkout"
    choice = gets.strip.to_i 
    case choice
    when 1
      main_order
    when 2
      side_order
    when 3 
      total_order
      total_price
      purchase_options
    else 
      puts "Invalid Option"
      extra_options
    end # end case 
  end


  def total_order
    puts "Your current order is:" 
    @cart_item.each do |n|
    puts "#{n}"
  end # end do 
  end #end total order 

  def total_price 
    puts "Your total is:" 
    @result = @cart_price.inject(0){|sum, x| sum + x}
    puts @result
  #   @cart_item.each_with_index do |p, i|
  #   puts " #{i + 1}) #{p}"
  # end # end do 
  end 

  def purchase_options 
    puts "Would you like to purchase your meal now?"
    puts "1) Yes"
    puts "2) No"
    choice = gets.strip.to_i 
    if choice == 1 
      purchase 
    elsif choice == 2 
      add_order #FIXED ITEM------
    else 
      puts "Invalid Option"
      purchase_options
    end #if 
  end 

  def add_order 
    puts "Would you like to another main dish, side dish, or remove an item?"
    puts "1) Add main dish"
    puts "2) Add side dish"
    puts "3) Remove an item"
    choice = gets.strip.to_i 
    case choice 
    when 1 
      main_order
    when 2 
      side_order
    when 3 
      remove_item
    else 
      puts "Invalid Option"
      add_order
    end 
  end 

    def purchase 
      if @result <= @user_wallet
        puts "Your change is: $#{ @user_wallet - @result}"
        puts "Thank you! Enjoy your meal, #{@user_name}!"
        exit 
      else 
        puts "Insufficient Funds." 
          clear_option 
      end #end if 
    end # end purchase 

    def clear_option 
      puts "Would you like to remove an item or clear your order?"
      puts "1) Remove item"
      puts "2) Clear order"
      choice = gets.strip.to_i
      case choice 
      when 1 
        remove_item
      when 2 
        remove_order
      else 
        puts "Invalid Option."
        clear_option
      end #end case 
    end # clear 

    def remove_item 
      puts "Pick an item to remove:\n"
      @cart_item.each_with_index do |n, i|
        puts "#{i + 1}) #{n}"
    end #end do 
      choice = gets.strip.to_i
      if choice > 0 && choice <= @cart_item.length 
        @cart_item.delete_at(choice - 1) # will delete item 
        @cart_price.delete_at(choice - 1) # will delete price 
        remove_add_item
      else 
        puts "Invalid Option"
        remove_item
      end #end if 
    end # end remove_item 

    def remove_add_item
      puts "Would you like to remove another item?"
      puts "1) Yes"
      puts "2) No"
      choice2 = gets.strip.to_i 
      case choice2
      when 1
        remove_item
      when 2
        purchase_options
      else
        puts "Invalid Option."
        remove_item
      end #end case 
    end


    def remove_order 
      @cart_item.clear 
      @cart_price.clear 
      main_order
    end 


end # LunchLady

binding.pry  # will start application 
LunchLady.new 

#multi class - for wallet, maindish, sidedishes, etc. 

#TODO - ERRORS 
#prints negative amounts 
#repeats both main and side dishes after add_order option main 1 
# Invalid option on remove item 