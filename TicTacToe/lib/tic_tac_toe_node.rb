require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @prev_move_pos = prev_move_pos
    @next_mover_mark = next_mover_mark
  end


  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_pos = []
    (0..2).each do |row_i|
      (0..2).each do |col_i|
        pos =[row_i,col_i]
        empty_pos << pos if @board.empty?(pos) 
      end
    end
    empty_pos.map do |pos|
       next_mark = (@next_mover_mark == :x ? :o : :x)
      new_node = TicTacToeNode.new(@board.dup,next_mark,pos) 
      new_node.board[pos] = @next_mover_mark
      new_node
    end
  end
  
  def losing_node?(evaluator)
    if @board.over?
      return @board.won? && @board.winner != evaluator
    end
    if self.next_mover_mark == evaluator
      children.all? { |node| node.losing_node?(evaluator) }
    else
      children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator
    end
    if self.next_mover_mark == evaluator
      children.any? { |node| node.winning_node?(evaluator) }
    else
      children.all? { |node| node.winning_node?(evaluator) }
    end
  end
end
