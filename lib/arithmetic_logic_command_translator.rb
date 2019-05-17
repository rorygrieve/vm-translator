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
        '// sub',
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
    when 'not'
      [
        '// not',
        '@SP',
        'A=M-1',
        'M=!M',
      ]
    when 'lt'
      [
        '// lt',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'D=M-D',
        '@TRUE',
        'D;JLT',
        '@FALSE',
        '0;JMP',
        '(TRUE)',
        '@SP',
        'A=M-1',
        'M=-1',
        '@FINISH',
        '0;JMP',
        '(FALSE)',
        '@SP',
        'A=M-1',
        'M=0',
        '(FINISH)',
      ]
    when 'gt'
      [
        '// gt',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'D=D-M',
        '@TRUE',
        'D;JLT',
        '@FALSE',
        '0;JMP',
        '(TRUE)',
        '@SP',
        'A=M-1',
        'M=-1',
        '@FINISH',
        '0;JMP',
        '(FALSE)',
        '@SP',
        'A=M-1',
        'M=0',
        '(FINISH)',
      ]
    when 'eq'
      [
        '// eq',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'D=M-D',
        '@TRUE',
        'D;JEQ',
        '@FALSE',
        '0;JMP',
        '(TRUE)',
        '@SP',
        'A=M-1',
        'M=-1',
        '@FINISH',
        '0;JMP',
        '(FALSE)',
        '@SP',
        'A=M-1',
        'M=0',
        '(FINISH)',
      ]
    else
      raise StandardError.new("Unrecognized command: #{command}")
    end
  end
end
