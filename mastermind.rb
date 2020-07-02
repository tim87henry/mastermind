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
        pp "Welcome to Mastermind. It's better than chess."
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
            if choice > 8 or choice < 1
                puts "Please enter a correct value from 1 to #{COLORS.length()}"
            else
                @select[i]=COLORS[choice-1]
                i+=1
            end
        end
    end

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
        puts "You have #{@exact_matches} exact matches and #{@imperfect_matches} imperfect matches"
    end
    
    def game_not_over?
        if @exact_matches == 4
            puts "Congrats. You win."
            false
        elsif @num_chances == 0
            print "Sorry, you're out of chances. The right sequence was : \n"
            puts @PUZZLE
            false
        else
            true
        end
    end

end

game_play = Mastermind.new()
game_play.play()