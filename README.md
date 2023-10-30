Running the Application:

Start the Robot Simulator by running the robot-simulator.rb script:

ruby robot-simulator.rb

The application will prompt you to enter commands. To get started, you must first use the PLACE command to place the robot on the tabletop.

Example:
Please enter your first command (PLACE X,Y,F)
PLACE 1,2,NORTH

Once the robot is placed, you can issue other commands like MOVE, LEFT, RIGHT, REPORT, or EXIT.

Running the Tests:

To run the unit tests for the Robot Simulator, you'll need the RSpec testing framework. If you don't have it installed, you can install it using:

gem install rspec

Then, you can run the tests using the following command:

rspec spec/robot_simulator_spec.rb
