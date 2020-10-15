=begin
    Author: David House
    Date: October 10, 2020
    Description: The class provides a user interface in playing the Hangman game. It displays rules, the name of the game, 
                the word to solve, and if a player guesses a letter correctly or not. The class must have a Hangman class as a parameter when instantiated.
=end

class GameInterface
    def initialize(game)
        @game_name = "Hangman"
        @game = game
    end

    def display_rules
        puts "Rules"
        puts "-----------------------------------"
        puts "Hangman is a game when you must guess the correct letters and uncover the hidden word."
        puts "A player has a maximum of six guesses. If the player exceeds the maximum guesses the game will end."
        puts "If a player can guess the word before exceeding maximum guesses, the player wins."
        puts
    end

    def display_game
        puts ""
        puts "You are playing #{@game_name}."
        puts "-----------------------------------"
        puts
    end

    def display_guess_word
        puts "Guess the word"
        puts "#{@game.hidden_word}"
        puts
    end

    def display_guesses
        puts "Letters used: #{@game.display_guesses}"
    end

    def gameplay
        display_game
        display_rules
        keepPlaying = true
        while keepPlaying
            display_guess_word
            display_guesses
            puts "Type 'exit' when you want to end the game."
            puts "Type 'hint' when you want to reveal one letter from the word. You can only use a hint once."
            puts "Enter a letter:"
            input = gets.chomp()

            if @game.user_exit(input)
                puts "Thank you for playing!"
                exit(0)
            end

            if @game.user_hint(input)
                puts
                puts "You used a hint. The letter is #{@game.get_hint}"
                puts
            end
                
            if @game.validate_input(input)
                @game.guess(input)
            else
                puts
                puts "Invalid input: please enter a letter or type 'exit' to end the game."
                puts
            end

            if check_win
                if play_again
                    @game.new_game
                else
                    keepPlaying = false
                end
            elsif check_loss
                if play_again
                    @game.new_game
                else
                    keepPlaying = false
                end
            end
        end
    end

    def check_win
        if @game.check_win
            puts
            puts "Congratulations! You uncovered all the letters."
            puts "The word was: #{@game.display_word}"
            puts "Thank you for playing!"
            puts
        end
        @game.check_win
    end

    def check_loss
        if @game.check_loss
            puts
            puts "Sorry, you have used all available guesses. You lost!"
            puts "The word was: #{@game.display_word}"
            puts "Thank you for playing!"
            puts
        end
        @game.check_loss
    end

    def play_again
        puts "Do you want to play again? (Y/N)"
        user_input = gets.chomp()
        case user_input
        when "y", "yes", "Y", "Yes"
            return true
        when "n", "no", "N", "No"
            return false
        else
            return false
        end
    end

    def start_game
        gameplay
    end
end