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
      translate_memory_access(split_line)
    when 1
      [
        '// add',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'M=D+M',
      ]
    end
  end

  def self.translate_memory_access(command)
    case command[0]
    when 'push'
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
    when 'pop'
      [
        "// #{command.join(" ")}",
        "@#{command[2]}",
        'D=A',
        '@LCL',
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
end
