=begin
    Author: David House
    Date: October 10, 2020
    Description: The Hangman class contains logic for the game of Hangman. It keeps track of player guesses, the letters used correctly or incorrectly.
                The class determines if a player reaches the maximum of guesses. The class validates if a guess is valid or not. The Hangman class
                also has reads from a file to get a list of words or if a file cannot be read then a default list of words are used instead.
                
=end

class Hangman
    def initialize
        @correct_guesses = []
        @incorrect_guesses = []
        @word_to_guess = word_list.sample.split("")
        @maximum_guesses = 6
        @guesses = 0
        @hint_used = false
    end

    def default_wordlist
        [   
            "Resident Evil",
            "Devil May Cry",
            "Call of Duty",
            "Guitar Hero",
            "Super Mario",
            "The Legend of Zelda",
            "Halo",
            "The Witcher",
            "Outlast",
            "Silent Hill",
            "Metal Gear Solid"
        ]
    end

    def word_list
        wordlist = []
        begin
            file = File.open("wordlist.txt")
            wordlist = file.readlines.map(&:chomp)
            file.close
        rescue
            wordlist = default_wordlist
            return wordlist
        end
        wordlist
    end

    def word_list_from_file
        
    end

    def new_game
        @correct_guesses = []
        @incorrect_guesses = []
        @word_to_guess = word_list.sample.split("")
        @guesses = 0
        @hint_used = false
    end

    def display_word
        new_word = ""
        @word_to_guess.each do |letter|
            new_word += letter
        end
        new_word
    end

    def display_guesses
        word = ""
        @incorrect_guesses.each do |letter|
            word += "#{letter} "
        end
        word.rstrip
    end

    def hidden_word
        hide_word = ""
        symbols = [",", "'", ":", " "]
        @word_to_guess.each do |letter|
            if symbols.include? (letter.downcase)
                hide_word += "#{letter} "
            elsif @correct_guesses.include? (letter.downcase)
                hide_word += "#{letter} "
            else
                hide_word += "_ "
            end
        end
        hide_word
    end

    def check_win
        symbols = [",", "'", ":", " "]
        @word_to_guess.each do |letter|
            unless symbols.include? (letter)
                unless @correct_guesses.include? (letter.downcase)
                    return false
                end
            end
        end
        true
    end

    def check_loss
        if @guesses >= @maximum_guesses
            return true
        end
        false
    end

    def guess (user_guess)
        if not has_guesses (user_guess)
            word = @word_to_guess.join("").downcase
            if word.include? (user_guess.downcase)
                puts "The answer: Correct"
                @correct_guesses.push(user_guess.downcase)
            else
                puts "The answer: Incorrect"
                @incorrect_guesses.push(user_guess.downcase)
                @guesses += 1
            end
        else
            puts "You have already used '#{user_guess}'. Please try a different letter."
        end
        word_list_from_file
    end

    def has_guesses (user_guess)
        if @correct_guesses.include? (user_guess)
            return true
        elsif @incorrect_guesses.include? (user_guess)
            return true
        end
        false
    end

    def validate_input (user_guess)
        if user_guess.class == String
            if user_guess == " "
                return false
            elsif user_guess.downcase == "exit"
                return true
            elsif user_guess.downcase == "hint"
                return true
            elsif not ("a"..."z").to_a.include? (user_guess.downcase)
                return false
            elsif user_guess.length == 1
                return true
            end
        end
        false
    end

    def user_exit (user_input)
        if user_input.downcase == "exit"
            return true
        end
        false
    end

    def display_size
        @word_to_guess.length
    end

    def user_hint (user_input)
        if user_input.downcase == "hint"
            return true
        end
        false
    end

    def get_hint
        hint = ""
        
        keepGoing = true
        while keepGoing
            hint = @word_to_guess.sample
            @word_to_guess.each do |character|
                unless character == " "
                    unless @correct_guesses.include? (hint.downcase)
                        hint = character
                        @hint_used = true
                        @correct_guesses.push(hint)
                        keepGoing = false
                    end
                end
            end
        end
        hint
    end
end