=begin
    Author: David House
    Date: October 10, 2020
    Description: The source file is the start of the application. The game of Hangman starts here.
                The file requires all the files needed to play the game and starts the game when running the file.
                
=end


require_relative 'hangman.rb'
require_relative 'gameInterface.rb'

ui = GameInterface.new(Hangman.new)
ui.start_game