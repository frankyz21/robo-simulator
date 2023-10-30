class Robot
  def initialize
    @x = 0
    @y = 0
    @facing = nil
    @tabletop_size = [5, 5]
  end
  def place(position_array, facing)
    if valid_position?(position_array[0].to_i, position_array[1].to_i)
      @x = position_array[0].to_i
      @y = position_array[1].to_i
      @facing = facing
    else
      loop do
        puts "Please enter the right position (X,Y,F):"
        input = gets.chomp.strip.upcase
        x,y, facing = input.split(",")

        if valid_position?(x.to_i, y.to_i) && ["EAST", "WEST", "NORTH", "SOUTH"].include?(facing)
          @x = x.to_i
          @y = y.to_i
          @facing = facing
          break
        else
          puts "Invalid position or facing direction. Please enter a valid position and facing direction."
        end
      end
    end  
  end

  def move
    case @facing
    when "NORTH"
      if @y < @tabletop_size[1] - 1
        @y += 1 
      else
        puts "You're exceding the limit, the robot is about to fall"
      end
    when "SOUTH"
      if @y > 0
        @y -= 1 
      else
        puts "You're exceding the limit, the robot is about to fall"
      end
    when "EAST"
      if @x < @tabletop_size[0] - 1
        @x += 1 
      else
        puts "You're exceding the limit, the robot is about to fall"
      end
    when "WEST"
      if @x > 0
        @x -= 1 
      else
        puts "You're exceding the limit, the robot is about to fall"
      end
    end
  end

  def left
    @facing = case @facing
              when "NORTH" then "WEST"
              when "SOUTH" then "EAST"
              when "EAST" then "NORTH"
              when "WEST" then "SOUTH"
              else @facing
              end
  end

  def right
    @facing = case @facing
              when "NORTH" then "EAST"
              when "SOUTH" then "WEST"
              when "EAST" then "SOUTH"
              when "WEST" then "NORTH"
              else @facing
              end
  end

  def report
    if on_table?
      puts "Your Robot is at (#{@x},#{@y}) facing #{@facing}"
    else
      puts "Robot is not on the table"
    end
  end

  private

  def valid_position?(x, y)
    x.between?(0, @tabletop_size[0] - 1) && y.between?(0, @tabletop_size[1] - 1)
  end

  def on_table?
    @x && @y && @facing
  end
end

def get_place_params(params)
  @x, @y, @facing = params.split(",")

  if !(0..4).include?(@x.to_i) && (0..4).include?(@y.to_i)
    puts "Invalid position. Please enter a position within the range (0,0) to (4,4)."
  end

  if !["EAST", "WEST", "NORTH", "SOUTH"].include?(@facing)
    puts "Invalid facing direction. Please enter a valid direction (EAST, WEST, NORTH, SOUTH)."
  end
  { position: [@x, @y], facing: @facing }

end



if __FILE__ == $0
  puts "Welcome to the Robot Simulations"
  robot = Robot.new
  first_command_entered = false



  while true
    if !first_command_entered
      puts "Please enter your first command (PLACE X,Y,F)"
    else
      puts "Please enter your next command (MOVE/LEFT/RIGHT/REPORT/EXIT)"
    end

    str = gets.chomp.strip.upcase
    command, params = str.split(" ")

    if !first_command_entered 
      if command == "PLACE" && !params.nil?
        @params = get_place_params(params)
        robot.place(@params[:position], @params[:facing])
        first_command_entered = true
      else
        puts "Invalid command. The first command must be 'PLACE X,Y,F'."
      end
    elsif first_command_entered
      case command
      when "MOVE"
        robot.move
        robot.report
      when "LEFT"
        robot.left
        robot.report
      when "RIGHT"
        robot.right
        robot.report
      when "REPORT"
        robot.report
      when "EXIT"
        break
      else
        puts "Invalid command. Please enter a valid command."
      end
    end
  end
  puts robot.inspect
end
