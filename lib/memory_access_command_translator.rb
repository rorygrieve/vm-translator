class MemoryAccessCommandTranslator
  SYMBOLS = {
    'local' => 'LCL',
    'argument' => 'ARG',
    'this' => 'THIS',
    'that' => 'THAT',
  }
  TEMP_BASE_MEMORY_ADDRESS = 5
  POINTER_BASE_MEMORY_ADDRESS = 3

  def self.call(command)
    case command[0]
    when 'push'
      convert_push_command(command)
    when 'pop'
      convert_pop_command(command)
    else
      raise_error(command)
    end
  end

  class <<self
    attr_accessor :filename
  end

  private

  def self.convert_push_command(command)
    case command[1]
    when 'constant'
      [
        "// #{command.join(" ")}",
        "@#{command[2]}",
        'D=A',
        '@SP',
        'A=M',
        'M=D',
        '@SP',
        'M=M+1',
      ]
    when 'local', 'argument', 'this', 'that'
      [
        "// #{command.join(" ")}",
        "@#{command[2]}",
        'D=A',
        "@#{SYMBOLS[command[1]]}",
        'A=D+M',
        'D=M',
        '@SP',
        'M=M+1',
        'A=M-1',
        'M=D',
      ]
    when 'temp'
      [
        "// #{command.join(" ")}",
        "@#{TEMP_BASE_MEMORY_ADDRESS + command[2].to_i}",
        'D=M',
        '@SP',
        'M=M+1',
        'A=M-1',
        'M=D',
      ]
    when 'pointer'
      [
        "// #{command.join(" ")}",
        "@#{POINTER_BASE_MEMORY_ADDRESS + command[2].to_i}",
        'D=M',
        '@SP',
        'M=M+1',
        'A=M-1',
        'M=D',
      ]
    when 'static'
      [
        "// #{command.join(" ")}",
        "@#{filename}.#{command[2]}",
        'D=M',
        '@SP',
        'M=M+1',
        'A=M-1',
        'M=D',
      ]
    else
      raise_error(command)
    end
  end

  def self.convert_pop_command(command)
    case command[1]
    when 'local', 'argument', 'this', 'that'
      [
        "// #{command.join(" ")}",
        "@#{command[2]}",
        'D=A',
        "@#{SYMBOLS[command[1]]}",
        'D=M+D',
        '@addr',
        'M=D',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        '@addr',
        'A=M',
        'M=D',
      ]
    when 'temp'
      [
        "// #{command.join(" ")}",
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        "@#{TEMP_BASE_MEMORY_ADDRESS + command[2].to_i}",
        'M=D',
      ]
    when 'pointer'
      [
        "// #{command.join(" ")}",
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        "@#{POINTER_BASE_MEMORY_ADDRESS + command[2].to_i}",
        'M=D',
      ]
    when 'static'
      [
        "// #{command.join(" ")}",
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        "@#{filename}.#{command[2]}",
        'M=D',
      ]
    else
      raise_error(command)
    end
  end

  def self.raise_error(command)
    raise StandardError.new("Cannot translate command: #{command.join(" ")}")
  end
end
