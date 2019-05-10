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
      [
        "// push constant #{split_line[2]}",
        "@#{split_line[2]}",
        'D=A',
        '@SP',
        'A=M',
        'M=D',
        '@SP',
        'M=M+1',
      ]
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
end
