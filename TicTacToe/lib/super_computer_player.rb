require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    non_losers = []
    node.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
      non_losers << child unless child.losing_node?(mark)
    end
    raise "There are no non losing nodes" if non_losers.empty?
    non_losers.sample.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
