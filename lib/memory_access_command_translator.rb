class MemoryAccessCommandTranslator
  SYMBOLS = {
    'local' => 'LCL',
    'argument' => 'ARG',
    'this' => 'THIS',
    'that' => 'THAT',
  }

  def self.call(command)
    case command[0]
    when 'push'
      convert_push_command(command)
    when 'pop'
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
    end
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
    else
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
    end
  end
end
