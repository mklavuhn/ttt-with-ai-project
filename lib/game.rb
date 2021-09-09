class Game 
    require 'pry'

    WIN_COMBINATIONS = [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]

    attr_accessor :board, :player_1, :player_2

    def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
        @board = board 
        @player_1 = player_1
        @player_2 = player_2
    end

    def current_player
        @board.turn_count.even? ? @player_1 : @player_2
    end

    def won?
        WIN_COMBINATIONS.detect do |array|
            @board.cells[array[0]] == @board.cells[array[1]] &&
            @board.cells[array[0]] == @board.cells[array[2]] &&
            @board.taken?(array[0] + 1)
        end
    end

    def draw? 
        !won? && @board.full? 
    end

    def over? 
        if won? || draw?
            true 
        else 
            false
        end
    end

    def winner 
        if winning_combo = won?
            @winner = @board.cells[winning_combo.first]
        end 
    end

    def turn 
        response = current_player.move(board)
        if @board.valid_move?(response)
            @board.update(response, current_player)
            @board.display
        else
            turn
        end
    end

    def play 
        until over? 
            self.turn
        end
        if won? 
            puts "Congratulations #{winner}!"
        else draw?
            puts "Cat's Game!"
        end

    end



end