class Mastermind
    
    COLORS = ["Red","Blue","Green","Yellow","Orange","Brown","Black","White"]
    COLORS_DISPLAY = {}
    for i in 0..COLORS.length()-1
        COLORS_DISPLAY[i+1] = COLORS[i]
    end
    
    def initialize
        @PUZZLE = []
        @select = []
        @num_chances = 10
        @exact_matches = 0
        @imperfect_matches = 0
        pp "Welcome to Mastermind. May the smartest person win."
        for i in 0..3
            pick=COLORS[rand(7)] if i == 0
            pick=COLORS[rand(7)] while @PUZZLE.include?pick
            @PUZZLE.push(pick)
        end
    end

    def play()
        while @num_chances >= 0 and game_not_over?
            @num_chances -= 1
            get_input 
            validate_input
        end
    end

    def get_input()
        puts "Enter the four numbers corresponding to your choices : #{COLORS_DISPLAY}"
        i=0
        while i < 4
            choice = gets.chomp.to_i
            if choice > 7 or choice < 1
                puts "Please enter a correct value from 1 to #{COLORS.length()-1}"
            else
                @select[i]=COLORS[choice-1]
                i+=1
            end
        end
    end

    def validate_input
        @exact_matches = 0
        @imperfect_matches = 0
        temp_colors=[]
        for i in 0..@select.length()-1
            
            if temp_colors.include?@select[i]
                break
            end

            if @PUZZLE[i] == @select[i]
                @exact_matches += 1
                temp_colors.push(@select[i])
            elsif @PUZZLE.include?@select[i]
                @imperfect_matches += 1
                temp_colors.push(@select[i])
            end
        end
        puts "You have #{@exact_matches} exact matches and #{@imperfect_matches} imperfect matches"
    end
    
    def game_not_over?
        if @exact_matches == 4
            pp "You win!!!"
            false
        elsif @num_chances == 0
            pp "Sorry, you're out of chances."
            false
        else
            true
        end
    end

end

game_play = Mastermind.new()
game_play.play()