class CodeWriter

  def self.call(code)
    code.map { |line|
      convert(line)
    }.flatten
  end

  private

  def self.convert(line)
    split_line = line.split
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
  end
end
