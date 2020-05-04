carregarNotas:-
    consult('BaseNotas.pl').
caderneta:-
    writeln("==================="),
    writeln("   Notas da Turma   "),
    writeln("===================="),
    nl,
    writeln("nome  N1 N2 N3 Media"),
    writeln("--------------------"),
    nota(Nome,N1,N2,N3),
    Media is (N1+N2+N3)/3,
    format('~w ~w  ~w  ~w  ~2f',[Nome,N1,N2,N3,Media]),
    nl,
    writeln("--------------------"),
    retract(nota(Nome,N1,N2,N3)),
    assert(nota(Nome,N1,N2,N3)),
    fail.

