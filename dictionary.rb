$grid_details = []
$matching_words_to_find = []

class Dictionary
 
  class << self

      #To find whether file or interactive mode
      def initiate
       give_welcome_msg
       receive_input
      end

      #To print welcome message
      def give_welcome_msg
        puts "Welcome to Dictionary app"
        puts "------------------------"
        puts "please enter a number larger than 0 to create grid"
      end

      #To receive input
      def receive_input
        command = STDIN.gets.strip
        number = command.split(' ')
        @number = number[0].to_i
        check_input_and_create_grid
      end

      #for checking input value and creating grid
      def check_input_and_create_grid
        check_if_the_number_suitable_for_creating_grid
        if @possibility == true
          create_grid_with_number
        else
          puts "Please enter a valid number to create grid"
          receive_input
        end  
      end  
      
      #For checking if the grid can be created with the number entered
      def check_if_the_number_suitable_for_creating_grid
        @possibility = @number > 0 ? true : false
      end  
      
      #Creating a grid with given number
      def create_grid_with_number
        $grid_details = Array.new(@number) { |row, col| (0...@number).map { (65 + rand(26)).chr } }
        puts "\n #{@number} x #{@number} grid created \n"
        @number.times do |i|
          puts "#{$grid_details[i]}"
        end  
        open_dictionary_file
        find_words_from_the_grid_created_and_find_mathing_ones
      end  

      #Open dict file from folder
      def open_dictionary_file
        File.open("dict.txt", "r") do |f|
          f.each_line do |line|
           array = line.split(' ')
           $matching_words_to_find << array[0]
          end
        end
        $matching_words_to_find = $matching_words_to_find.uniq
        # puts $matching_words_to_find
      end  

      def find_words_from_the_grid_created_and_find_mathing_ones
        find_horizontal_words_left_to_right
        find_horizontal_words_right_to_left
        find_vertical_words_top_to_bottom
        find_vertical_words_bottom_to_top
        find_diagonal_words_left_to_right
        find_all_the_words_that_matches_from_dictionary
      end

      #To find all the horizontal words from left to right from the grid created
      def find_horizontal_words_left_to_right
        @horizontal_left_to_right = []
        @number.times do |i|
          @horizontal_left_to_right << $grid_details[i].join("") 
        end
      end  

      #To find all the horizontal words from right to left from the grid created
      def find_horizontal_words_right_to_left
        @horizontal_right_to_left = []
        @horizontal_left_to_right.each do |word, i|
          @horizontal_right_to_left << word.reverse 
        end
      end

      #To find all the vertical words from top to bottom from the grid created
      def find_vertical_words_top_to_bottom
        @vertical_top_to_bottom = $grid_details.transpose.map {|e| e.inject(:+)}     
      end

      #To find all the vertical words from bottom to top from the grid created
      def find_vertical_words_bottom_to_top
        @vertical_bottom_to_top = $grid_details.transpose.map {|e| e.inject(:+)}.map {|word| word.reverse}
      end

      def find_diagonal_words_left_to_right
       @diagonal_left_to_right = $grid_details.map.with_index {|row, i| row[i]}.inject(:+)
      end

      def find_diagonal_words_right_to_left

      end  

      #To check all the matching words from dictionary
      def find_all_the_words_that_matches_from_dictionary
        horizontal_match_left_to_right = $matching_words_to_find & @horizontal_left_to_right
        horizontal_match_right_to_left = $matching_words_to_find & @horizontal_right_to_left
        vertical_match_top_to_bottom = $matching_words_to_find & @vertical_top_to_bottom
        vertical_match_bottom_to_top = $matching_words_to_find & @vertical_bottom_to_top
        puts "Horizontal matching words from left to right are #{horizontal_match_left_to_right}"
        puts "Horizontal matching words from right to left are #{horizontal_match_right_to_left}"
        puts "vertical matching words from top to bottom are #{vertical_match_top_to_bottom}"
        puts "vertical matching words from bottom to top are #{vertical_match_bottom_to_top}"
      end  
 
   end #End of self class
end #End of Dictionary class

