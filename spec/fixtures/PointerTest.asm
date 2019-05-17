// push constant 3030
@3030
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
A=M
D=M
@3
M=D
// push constant 3040
@3040
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D
// push constant 32
@32
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop this 2
@2
D=A
@THIS
D=M+D
@addr
M=D
@SP
M=M-1
A=M
D=M
@addr
A=M
M=D
// push constant 46
@46
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop that 6
@6
D=A
@THAT
D=M+D
@addr
M=D
@SP
M=M-1
A=M
D=M
@addr
A=M
M=D
// push pointer 0
@3
D=M
@SP
M=M+1
A=M-1
M=D
// push pointer 1
@4
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
M=M-1
A=M
D=M
A=A-1
M=D+M
// push this 2
@2
D=A
@THIS
A=D+M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
M=M-1
A=M
D=M
A=A-1
M=M-D
// push that 6
@6
D=A
@THAT
A=D+M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
M=M-1
A=M
D=M
A=A-1
M=D+M
