% This buffer is for notes you doprin't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.
%
prog:-
    writeln( '----------------'),
    writeln( '===== MENU ====='),
    writeln( '----------------'),
    writeln('Escolha op��o :'),
    nl,
    writeln('1-Soma.'),
    writeln('2-Subtra��o.'),
    writeln('3-Divis�o.'),
    writeln('4-Multiplica��o.'),
    writeln('5-Sair.'),
    nl,
    writeln('Informe a op��o: '),
    read(Entrada),
    Entrada =\= 5,
    executa( Entrada ),
    prog.
prog:-
    write('Encerrando programa!!!'),!.
executa(1):-
    op1.
executa(2):-
    op2.
executa(3):-
    op3.
executa(4):-
    op4.
op1:-
    writeln('Op��o 1 selecionada'),
    writeln('Soma: A + B'),
    write('Digite A'),
    read(A),
    write('Digite B'),
    read(B),
    Soma is A+B,
    nl,
    write(A),write(' + '),
    write(B),write(' = '), write(Soma),nl,nl.
op2:-
    writeln('Op��o 2 selecionada'),
    writeln('Subtra��o: A - B '),
    write('Digite A: '),
    read(A),
    write('Digite B: '),
    read(B),
    nl,
    Sub is A-B,
    nl,
    write(A),write(' - '),
    write(B),write(' = '),write(Sub),nl,nl.
op3:-
    writeln('Op��o 3 selecionada'),
    writeln('Divis�o: A / B '),
    write('Digite A: '),
    read(A),
    write('Digite B: '),
    read(B),
    nl,
    div(A,B).
div(_,0):-
    writeln('Divis�o por 0.'),nl.

div(A,B):-
    Div is A/B,
    nl,
    write(A),write(' / '),
    write(B),write(' = '),write(Div),nl,nl.

op4:-
    writeln('Op��o 4 selecionada'),
    writeln('Multiplica��o: A * B'),
    write('Digite A: '),
    read(A),
    write('Digite B: '),
    read(B),
    nl,
    Mult is A*B,
    nl,
    write(A),write(' * '),
    write(B),write(' = '),write(Mult),
    nl,nl.














