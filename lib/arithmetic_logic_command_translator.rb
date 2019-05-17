class ArithmeticLogicCommandTranslator
  @@number = 0
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
      next_number
      [
        '// lt',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'D=M-D',
        "@TRUE.#{@@number}",
        'D;JLT',
        "@FALSE.#{@@number}",
        '0;JMP',
        "(TRUE.#{@@number})",
        '@SP',
        'A=M-1',
        'M=-1',
        "@FINISH.#{@@number}",
        '0;JMP',
        "(FALSE.#{@@number})",
        '@SP',
        'A=M-1',
        'M=0',
        "(FINISH.#{@@number})",
      ]
    when 'gt'
      next_number
      [
        '// gt',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'D=D-M',
        "@TRUE.#{@@number}",
        'D;JLT',
        "@FALSE.#{@@number}",
        '0;JMP',
        "(TRUE.#{@@number})",
        '@SP',
        'A=M-1',
        'M=-1',
        "@FINISH.#{@@number}",
        '0;JMP',
        "(FALSE.#{@@number})",
        '@SP',
        'A=M-1',
        'M=0',
        "(FINISH.#{@@number})",
      ]
    when 'eq'
      next_number
      [
        '// eq',
        '@SP',
        'M=M-1',
        'A=M',
        'D=M',
        'A=A-1',
        'D=M-D',
        "@TRUE.#{@@number}",
        'D;JEQ',
        "@FALSE.#{@@number}",
        '0;JMP',
        "(TRUE.#{@@number})",
        '@SP',
        'A=M-1',
        'M=-1',
        "@FINISH.#{@@number}",
        '0;JMP',
        "(FALSE.#{@@number})",
        '@SP',
        'A=M-1',
        'M=0',
        "(FINISH.#{@@number})",
      ]
    else
      raise StandardError.new("Unrecognized command: #{command}")
    end
  end

  private

  def self.next_number
    @@number += 1
  end
end
