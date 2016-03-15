class Board
  attr_accessor :marked_box_count
  attr_accessor :victory
  attr_accessor :tie

  @@conditions_for_win = [
                          [6, 4, 2], [2, 5, 8], [6, 7, 8], [3, 4, 5],
                          [1, 4, 7], [0, 3, 6], [0, 4, 8], [0, 1, 2]
                         ]
  @@box_objects = []
  def initialize(box_object)
    @victory = false
    @tie = false
    @marked_box_count = 0

    (0..8).each do |id|
      @@box_objects << box_object.initialize_box()
    end
  end

  def is_box_marked?(box_object)
    box_object.marked == true
  end

  def mark_box(id)
    box_object = @@box_objects[id]
    if !is_box_marked?(box_object)
      box_object.marked = true
      self.marked_box_count += 1
      return true
    end
    return false
  end

  def check_for_victory(marked_boxes)
    @@conditions_for_win.each do |cond1|
      not_matched = false
      cond1.each do |id|
        if !marked_boxes.include?(id)
          not_matched = true
          break
        end
      end
      if !not_matched
        self.victory = true
        break
      end
    end
    if !self.victory and self.marked_box_count == 9
      self.tie = true
    end
  end

  def get_box_objects
    puts @@box_objects
  end
end

class Box
  attr_accessor :marked
  def initialize
    @marked = false
  end

  def initialize_box
    Box.new
  end
end

class Player
  attr_accessor :marked_boxes
  attr_accessor :player_name

  def initialize(player_name)
    @player_name = player_name
    @marked_boxes = []
  end

  def mark_box(board_obj, id)
    id = id.to_i
    marked_boxes << id
    board_obj.mark_box(id)
  end

  def message(msg_string, player_name = "")
    if !player_name.empty?
      puts "#{player_name} #{msg_string}"
    else
      puts "#{msg_string}"
    end
  end

  def check_for_victory(board_obj)
    board_obj.check_for_victory(marked_boxes)
    if board_obj.victory
      message('wins', player_name) 
      return true
    end

    if board_obj.tie
      message('Its a tie')
      return true
    end
  end

  def show_marked_boxes
    if !marked_boxes.empty?
      puts "#{player_name} selected boxes are: #{marked_boxes}"
    else
      puts "#{player_name} you have not selected anything"
    end
  end

end

# class Game
#   attr_accessor :current_player
#   def initialize(player)
#     @current_player = player
#   end
# end

b1 = Board.new(Box.new)

pl1 = Player.new('player1')
pl2 = Player.new('player2')

id_array = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
victory = false
unless victory
  id_array.each do |subset|
    subset.each do |id|
      print "|"
      print id
    end
    puts
  end
  (0..8).each do |iteration|
    pl1.show_marked_boxes()
    puts "#{pl1.player_name} enter a box number for marking"
    id = gets.chomp
    while id.empty?
      pl1.show_marked_boxes()
      puts "#{pl1.player_name} enter a box number for marking"
      id = gets.chomp
    end
    pl1.mark_box(b1, id)
    victory = pl1.check_for_victory(b1)
    
    break if victory
    
    pl2.show_marked_boxes()
    puts "#{pl2.player_name} enter a box number for marking"
    id = gets.chomp
    while id.empty?
      pl2.show_marked_boxes()
      puts "#{pl2.player_name} enter a box number for marking"
      id = gets.chomp
    end
    pl2.mark_box(b1, id)
    victory = pl2.check_for_victory(b1)

    puts
    puts
  end
end
