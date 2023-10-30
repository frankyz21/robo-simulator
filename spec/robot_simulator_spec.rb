require_relative '../robot-simulator'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  it "places the robot at the specified position" do
    robot.place([1, 2], 'NORTH') 
    expect(robot.instance_variable_get(:@x)).to eq(1)
    expect(robot.instance_variable_get(:@y)).to eq(2)
    expect(robot.instance_variable_get(:@facing)).to eq('NORTH')
  end

  it "does not place the robot outside the table" do
    expect { robot.place([6, 2], 'NORTH') }.to raise_error
    expect { robot.place([-1, 2], 'NORTH') }.to raise_error
    expect { robot.place([1, 6], 'NORTH') }.to raise_error
    expect { robot.place([1, -1], 'NORTH') }.to raise_error
  end

  it "does not place the robot with an invalid facing direction" do
    expect { robot.place([1, 2], 'INVALID') }.to_not raise_error
  end

  it "moves the robot north" do
    robot.place([1, 2], 'NORTH')
    robot.move
    expect(robot.instance_variable_get(:@x)).to eq(1)
    expect(robot.instance_variable_get(:@y)).to eq(3)
    expect(robot.instance_variable_get(:@facing)).to eq('NORTH')
  end

  it "moves the robot south" do
    robot.place([1, 2], 'SOUTH')
    robot.move
    expect(robot.instance_variable_get(:@x)).to eq(1)
    expect(robot.instance_variable_get(:@y)).to eq(1)
    expect(robot.instance_variable_get(:@facing)).to eq('SOUTH')
  end

  it "moves the robot east" do
    robot.place([1, 2], 'EAST')
    robot.move
    expect(robot.instance_variable_get(:@x)).to eq(2)
    expect(robot.instance_variable_get(:@y)).to eq(2)
    expect(robot.instance_variable_get(:@facing)).to eq('EAST')
  end

  it "moves the robot west" do
    robot.place([1, 2], 'WEST')
    robot.move
    expect(robot.instance_variable_get(:@x)).to eq(0)
    expect(robot.instance_variable_get(:@y)).to eq(2)
    expect(robot.instance_variable_get(:@facing)).to eq('WEST')
  end

  it "does not move the robot outside the table" do
    robot.place([4, 4], 'NORTH')
    robot.move
    expect(robot.instance_variable_get(:@x)).to eq(4)
    expect(robot.instance_variable_get(:@y)).to eq(4)
    expect(robot.instance_variable_get(:@facing)).to eq('NORTH')
  end

  it "does not move the robot if not placed" do
    expect { robot.move }.to_not raise_error
    expect(robot.instance_variable_get(:@x)).to eq(0)
    expect(robot.instance_variable_get(:@y)).to eq(0)
    expect(robot.instance_variable_get(:@facing)).to be_nil
  end

  it "rotates the robot left" do
    robot.place([1, 2], 'NORTH')
    robot.left
    expect(robot.instance_variable_get(:@x)).to eq(1)
    expect(robot.instance_variable_get(:@y)).to eq(2)
    expect(robot.instance_variable_get(:@facing)).to eq('WEST')
  end

  it "rotates the robot right" do
    robot.place([1, 2], 'NORTH')
    robot.right
    expect(robot.instance_variable_get(:@x)).to eq(1)
    expect(robot.instance_variable_get(:@y)).to eq(2)
    expect(robot.instance_variable_get(:@facing)).to eq('EAST')
  end

  it "reports the robot position and facing direction" do
    robot.place([1, 2], 'NORTH')
    expect { robot.report }.to output("Your Robot is at (1,2) facing NORTH\n").to_stdout
  end
end
