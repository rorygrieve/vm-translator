require_relative './memory_access_command_translator'
require_relative './arithmetic_logic_command_translator'

class CodeWriter
  def self.call(code)
    code.map { |line|
      convert(line)
    }.flatten
  end

  private

  def self.convert(line)
    split_line = line.split

    case split_line.length
    when 3
      MemoryAccessCommandTranslator.call(split_line)
    when 1
      ArithmeticLogicCommandTranslator.call(line)
    end
  end
end
