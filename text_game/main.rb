class Game
    attr_accessor :current_room
  
    def initialize
      @rooms = {}
      create_rooms
      @current_room = @rooms[:entrance]
      @inventory = []
    end
  
    def create_rooms
      @rooms[:entrance] = Room.new("Entrance", "You are at the entrance of a mysterious cave. A dark passage lies ahead.")
      @rooms[:hallway] = Room.new("Hallway", "A narrow hallway with flickering torches on the walls. There's a door to the north.")
      @rooms[:treasure_room] = Room.new("Treasure Room", "You've found the treasure room! But it’s guarded by a fierce dragon.")
      @rooms[:trap_room] = Room.new("Trap Room", "You step into a room and hear a click. The door slams shut behind you.")
  
      # Define room connections
      @rooms[:entrance].set_exits({ north: @rooms[:hallway] })
      @rooms[:hallway].set_exits({ south: @rooms[:entrance], north: @rooms[:trap_room], east: @rooms[:treasure_room] })
      @rooms[:trap_room].set_exits({ south: @rooms[:hallway] }) # Exit only available after solving puzzle
      @rooms[:treasure_room].set_exits({ west: @rooms[:hallway] })
  
      # Add items to rooms
      @rooms[:entrance].add_item("map", "A dusty old map that might be useful.")
      @rooms[:hallway].add_item("key", "An ancient key, perhaps it opens a door.")
    end
  
    def start
      puts "Welcome to Ruby Adventure Game!"
      puts "Type 'help' for a list of commands."
      loop do
        display_room
        input = gets.chomp.downcase
        handle_input(input)
      end
    end
  
    def display_room
      puts "\n#{@current_room.name}"
      puts @current_room.description
      @current_room.display_items
    end
  
    def handle_input(input)
      case input
      when "help"
        puts "Commands: look, north, south, east, west, take <item>, use <item>, inventory, exit"
      when "look"
        display_room
      when "inventory"
        display_inventory
      when /^take (.+)$/
        take_item($1)
      when /^use (.+)$/
        use_item($1)
      when "north", "south", "east", "west"
        move(input.to_sym)
      when "exit"
        puts "Thanks for playing!"
        exit
      else
        puts "I don't understand that command."
      end
    end
  
    def move(direction)
      if @current_room.exits[direction]
        @current_room = @current_room.exits[direction]
        if @current_room == @rooms[:trap_room]
          trap_puzzle
        end
      else
        puts "You can't go that way."
      end
    end
  
    def take_item(item_name)
      item = @current_room.remove_item(item_name)
      if item
        @inventory << item
        puts "You took the #{item_name}."
      else
        puts "There's no #{item_name} here."
      end
    end
  
    def use_item(item_name)
      case item_name
      when "map"
        if @inventory.any? { |item| item.name == "map" }
          puts "The map shows a secret exit in the trap room!"
        else
          puts "You don't have a map."
        end
      when "key"
        if @inventory.any? { |item| item.name == "key" }
          if @current_room == @rooms[:trap_room]
            puts "You use the key to unlock the door in the trap room!"
            @rooms[:trap_room].set_exits({ south: @rooms[:hallway], north: @rooms[:treasure_room] })
          else
            puts "You can't use the key here."
          end
        else
          puts "You don't have a key."
        end
      else
        puts "You don't have that item."
      end
    end
  
    def display_inventory
      if @inventory.empty?
        puts "Your inventory is empty."
      else
        puts "You are carrying:"
        @inventory.each { |item| puts "- #{item.name}" }
      end
    end
  
    def trap_puzzle
      puts "The door slams shut behind you! You need to find a way out."
      puts "There's a locked door to the north."
      if @inventory.any? { |item| item.name == "key" }
        puts "You have a key that might open it."
      else
        puts "You might need to find a key."
      end
    end
  end
  
  class Room
    attr_accessor :name, :description, :exits
  
    def initialize(name, description)
      @name = name
      @description = description
      @items = []
      @exits = {}
    end
  
    def set_exits(exits)
      @exits = exits
    end
  
    def add_item(name, description)
      @items << Item.new(name, description)
    end
  
    def remove_item(name)
      item = @items.find { |item| item.name == name }
      @items.delete(item)
      item
    end
  
    def display_items
      if @items.empty?
        puts "There are no items here."
      else
        puts "You see:"
        @items.each { |item| puts "- #{item.name}: #{item.description}" }
      end
    end
  end
  
  class Item
    attr_accessor :name, :description
  
    def initialize(name, description)
      @name = name
      @description = description
    end
  end
  
  # Start the game
  game = Game.new
  game.start
  