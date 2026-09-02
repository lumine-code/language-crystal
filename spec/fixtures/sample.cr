# Grammar assertions for Crystal.
# <- comment.line.number-sign.crystal
# <- punctuation.definition.comment.crystal

module Lumine
# <- storage.type.crystal
#      ^ entity.name.type.module.crystal
  class Counter
  # <- storage.type.crystal
  #     ^ entity.name.type.class.crystal
    @@instances = 0
    # <- variable.other.readwrite.class.crystal
                 # ^ constant.numeric.integer.crystal

    def initialize(@name : String, step = 1)
    # <- storage.type.function.crystal
    #   ^ entity.name.function.method.crystal
                   # ^ variable.other.readwrite.instance.crystal
                           # ^ support.class.crystal
                                   # ^ variable.parameter.function.crystal
      @count = step
      # <- variable.other.readwrite.instance.crystal
            #^ keyword.operator.crystal
      pattern = /item-\\d+/i
      #         ^ string.regexp.crystal
                          #^ storage.modifier.regexp.crystal
      puts "Hello #{@name}"
      # <- support.other.function.crystal
           # ^ string.quoted.double.crystal
                  #^ punctuation.section.embedded.begin.crystal
    end
    # <- keyword.control.crystal

    def increment(amount = 1)
      @count += amount
      @count
    end
  end
end
