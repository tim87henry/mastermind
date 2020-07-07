module Validate

    def validate_input
        @exact_matches = 0
        @imperfect_matches = 0
        exact_colors=[]
        imperfect_colors=[]
        for i in 0..@select.length()-1
            
            if exact_colors.include?@select[i]
                next
            end

            if @PUZZLE[i] == @select[i]
                @exact_matches += 1
                exact_colors.push(@select[i])
                @imperfect_matches -= 1 if imperfect_colors.include?@select[i]
            elsif @PUZZLE.include?@select[i]
                @imperfect_matches += 1 unless imperfect_colors.include?@select[i]
                imperfect_colors.push(@select[i])
            end
        end
        puts "#{@exact_matches} exact matches and #{@imperfect_matches} imperfect matches"
    end


    def game_not_over?
        if @exact_matches == 4
            puts "Congrats. You win."
            false
        elsif @num_chances == 0
            puts "Sorry, you're out of chances. The right sequence was : \n#{@PUZZLE}"
            false
        else
            true
        end
    end
end

module ComputerPlay

    include Validate

    def computer_play()
        set_code
        @try=0
        @exact_choices=[]
        while @num_chances >= 0 and game_not_over?
            @num_chances -= 1
            simulate_play
            validate_input
            calculate_guess
        end
    end

    def set_code()
        puts "Enter the numbers to form your code, in order : #{@COLORS_DISPLAY}"
        i=0
        choices=[]
        while i < 4
            choice = gets.chomp.to_i
            if choice > 8 or choice < 1 or choices.include?choice
                puts "Please enter a correct value from 1 to #{@COLORS.length()}"
            else
                @PUZZLE[i]=@COLORS[choice-1]
                choices[i]=choice
                i+=1
            end
        end
    end

    def simulate_play()
        if @exact_choices.length < 4
            @select.push(@COLORS[@try],@COLORS[@try],@COLORS[@try],@COLORS[@try])
        else 
            picks=[]
            for i in 0..3
                pick=@exact_choices[rand(4)] if i == 0
                pick=@exact_choices[rand(4)] while picks.include?pick
                picks.push(pick)
                @select.push(@COLORS[pick])
            end
        end
        puts "The computer has chosen : #{@select}"
    end

    def calculate_guess()
        @select=[]
        if @exact_choices.length < 4 
            if @exact_matches > 0
                @exact_choices.push(@try)
            end
            @try += 1
        end
        
    end

end

module UserPlay
    
    include Validate
    
    def user_play()
        for i in 0..3
            pick=@COLORS[rand(7)] if i == 0
            pick=@COLORS[rand(7)] while @PUZZLE.include?pick
            @PUZZLE.push(pick)
        end
        
        while @num_chances >= 0 and game_not_over?
            @num_chances -= 1
            get_input 
            validate_input
        end
    end

    def get_input()
        puts "Enter the four numbers corresponding to your choices : #{@COLORS_DISPLAY}"
        i=0
        while i < 4
            choice = gets.chomp.to_i
            if choice > 8 or choice < 1
                puts "Please enter a correct value from 1 to #{@COLORS.length()}"
            else
                @select[i]=@COLORS[choice-1]
                i+=1
            end
        end
    end
    
end


class Mastermind
    include ComputerPlay 
    include UserPlay
       
    def initialize
        @COLORS = ["Red","Blue","Green","Yellow","Orange","Brown","Black","White"]
        @COLORS_DISPLAY = {}
        for i in 0..@COLORS.length()-1
            @COLORS_DISPLAY[i+1] = @COLORS[i]
        end
        @PUZZLE = []
        @select = []
        @num_chances = 10
        @exact_matches = 0
        @imperfect_matches = 0
        
    end

    def play
        puts "Welcome to Mastermind. Do you want to : "
        puts "1. Code breaker"
        puts "2. Code maker"
        mode=0
        correct_mode=false
        until correct_mode
            mode = gets.chomp.to_i
            if mode == 1 or mode == 2
                correct_mode = true
            else
                puts "Please enter either 1 or 2"
            end
        end
        if mode == 1
            user_play
        elsif mode == 2
            computer_play
        end
    end

end

game_play = Mastermind.new()
game_play.play