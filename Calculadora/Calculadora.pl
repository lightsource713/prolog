% This buffer is for notes you doprin't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.
%
prog:-
    writeln( '----------------'),
    writeln( '===== MENU ====='),
    writeln( '----------------'),
    writeln('Escolha opção :'),
    nl,
    writeln('1-Soma.'),
    writeln('2-Subtração.'),
    writeln('3-Divisão.'),
    writeln('4-Multiplicação.'),
    writeln('5-Sair.'),
    nl,
    writeln('Informe a opção: '),
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
    writeln('Opção 1 selecionada'),
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
    writeln('Opção 2 selecionada'),
    writeln('Subtração: A - B '),
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
    writeln('Opção 3 selecionada'),
    writeln('Divisão: A / B '),
    write('Digite A: '),
    read(A),
    write('Digite B: '),
    read(B),
    nl,
    div(A,B).
div(_,0):-
    writeln('Divisão por 0.'),nl.

div(A,B):-
    Div is A/B,
    nl,
    write(A),write(' / '),
    write(B),write(' = '),write(Div),nl,nl.

op4:-
    writeln('Opção 4 selecionada'),
    writeln('Multiplicação: A * B'),
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














