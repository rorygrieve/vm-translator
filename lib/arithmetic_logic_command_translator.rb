class ArithmeticLogicCommandTranslator
  def self.call(command)
    case command
    when 'add'
      [
        '// add',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'M=D+M',
      ]
    when 'sub'
      [
        '// subtract',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'M=M-D',
      ]
    when 'neg'
      [
        '// neg',
        '@SP',
        'A=M',
        'M=-M',
      ]
    when 'and'
      [
        '// and',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'M=D&M',
      ]
    when 'or'
      [
        '// or',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'M=D|M',
      ]
    else
      raise StandardError.new("Unrecognized command: #{command}")
    end
  end
end
