module Lumine
  class Counter
    @@instances = 0

    def initialize(@name : String, step = 1)
      @count = step
      pattern = /item-\\d+/i
      puts "Hello #{@name}"
    end

    def increment(amount = 1)
      @count += amount
      @count
    end
  end
end
