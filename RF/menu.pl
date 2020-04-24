:- dynamic dependente/4.
:- dynamic contribuinte/11.
:- dynamic soma/1.
:- dynamic ranual/1.
:- dynamic total/1.

rf:-
    assertz(valor(0)),
    write('\e[23'),
    nl,
    write('================================================='),nl,
    write('=                Receita Federal                ='),nl,
    write('================================================='),nl,
    write('| 1- Incluir Contribuinte                       |'),nl,
    write('| 2- Incluir Dependente                         |'),nl,
    write('| 3- Localizar Contribuinte pelo CPF            |'),nl,
    write('| 4- Excluir contribuinte e seus Dependentes    |'),nl,
    write('| 5- Relatorio de Contribuintes                 |'),nl,
    write('| 6- Total de Dependentes por Contribuinte      |'),nl,
    write('| 7- Salvar os Dados em um arquivo              |'),nl,
    write('| 8- Carregar os Dados do Arquivo               |'),nl,
    write('| 9- Limpar os Dados de Cadastro                |'),nl,
    write('| 0- Sair                                       |'),nl,
    write('================================================='),nl,
    write('Informe uma das opcoes abaixo: '),
    read(Op),
    Op=\=0,
    executa(Op),
    rf.

executa(1):-
    write('Digite o CPF: '),
    read(CPF),
    write('Digite o Nome: '),
    read(Nome),
    write('Digite o Genero: '),
    read(Genero),
    write('Digite o Renda: '),
    read(Renda),
    write('Digite o Logradouro: '),
    read(Log),
    write('Digite o Numero: '),
    read(Num),
    write('Digite o Complemento: '),
    read(Comple),
    write('Digite a Cidade: '),
    read(Cidade),
    write('Digite o Estado: '),
    read(Estado),
    write('Digite seu CEP: '),
    read(CEP),
    write('Digite seu Celular: '),
    read(Celular),
    create_contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular).

executa(2):-
    write('Digite o CPF: '),
    read(CPF),
    write('Digite o Nome: '),
    read(Nome),
    write('Digite o Idade: '),
    read(Idade),
    write('Digite o Genero: '),
    read(Genero),
    create_dependente(CPF,Nome,Idade,Genero).

executa(3):-
    write('Digite o CPF: '),
    read(CPF),
    procurar(CPF).

executa(4):-
    write('Digite o CPF: '),
    read(CPF),
    excluir_Cpf(CPF).

executa(5):-
    relatorio.

executa(6):-
    somarD,
    retract(total(T)),
    assert(total(0)),
    X is T - 1,
    format('Total de Dependentes: ~w',[X]).

executa(7):-
    writeln("Arquivos São Salvos Automaticamente").

executa(8):-
    carregar_contribuintes,
    carregar_dependentes,
    write('Carregando arquivos...').

executa(9):-
    excluir.


carregar_contribuintes:-
    consult('contribuintes.txt'),
    retractall(ranual(_)),
    assert(ranual(0)).

carregar_dependentes:-
    consult('dependentes.txt'),
    retractall(total(_)),
    assert(total(0)),
    retractall(soma(_)),
    assert(total(0)).


procurar(CPF):-
    contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular),
    write('CPF: '),
    write(CPF),nl,
    write('Nome: '),
    write(Nome),nl,
    write('Genero: '),
    write(Genero),nl,
    write('Renda: '),
    write(Renda),nl,
    write('Logradouro: '),
    write(Log),nl,
    write('Numero: '),
    write(Num),nl,
    write('Complemento: '),
    write(Comple),nl,
    write('Cidade: '),
    write(Cidade),nl,
    write('Estado: '),
    write(Estado),nl,
    write('CEP: '),
    write(CEP),nl,
    write('Celular: '),
    write(Celular),nl,
    retract(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    assertz(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)).
procurar(CPF):-
    dependente(CPF,Nome,Idade,Genero),
    write('Dependentes :'),nl,
    write('Nome: '),
    write(Nome),nl,
    write('Idade: '),
    write(Idade),nl,
    write('Genero: '),
    write(Genero),nl,
    retractall(dependente(CPF,Nome,Idade,Genero)),
    assertz(dependente(CPF,Nome,Idade,Genero)).


create_dependente(CPF,Nome,Idade,Genero):-
    carregar_dependentes,
    carregar_contribuintes,
    contribuinte(CPF,_,_,_,_,_,_,_,_,_,_),
    open('dependentes.txt',append,Stream,[create([read,write,execute])]),
    write(Stream,dependente(CPF,Nome,Idade,Genero)),
    write(Stream,.),
    nl(Stream),
    close(Stream),
    carregar_dependentes.

create_contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular):-
    carregar_contribuintes,
    open('contribuintes.txt',append,Stream,[create([read,write,execute])]),
    write(Stream,contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    write(Stream,.),
    nl(Stream),
    close(Stream),
    carregar_contribuintes.

excluir_contrinuinte(CPF) :-
    retract(contribuinte(CPF,_,_,_,_,_,_,_,_,_,_)),
    contribuinte(CPf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular),
    open('contribuintes.txt',append,Stream,[create([read,write,execute])]),
    write(Stream,contribuinte(CPf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    write(Stream,.),
    nl(Stream),
    close(Stream),
    retract(contribuinte(CPf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    assertz(contribuinte(CPf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    fail.

excluir_dependente(CPF):-
    retractall(dependente(CPF,_,_,_)),
    dependente(CPf,Nome,Idade,Genero),
    open('dependentes.txt',append,Stream,[create([read,write,execute])]),
    write(Stream,dependente(CPf,Nome,Idade,Genero)),
    write(Stream,.),
    nl(Stream),
    close(Stream),
    retract(dependente(CPf,Nome,Idade,Genero)),
    assertz(dependente(CPf,Nome,Idade,Genero)),
    fail.

excluir_Cpf(CPF):-
    carregar_contribuintes,
    carregar_dependentes,
    excluir,
    not(excluir_contrinuinte(CPF)),
    not(excluir_dependente(CPF)).


excluir:-
    delete_file('contribuintes.txt'),
    delete_file('dependentes.txt'),
    open('contribuintes.txt',append,Stream1,[create([read,write,execute])]),
    close(Stream1),
    open('dependentes.txt',append,Stream2,[create([read,write,execute])]),
    close(Stream2).

relatorio:-
    retract(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    format('Contribuinte: ~w ~n CPF: ~w, Genero: ~w, Renda: ~w ~n Log: ~w, Comple: ~w, Cidade: ~w ~n Estado: ~w, CEP: ~w, Celular: ~w ~n',[Nome,CPF,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular]),
    rel_depend(CPF),
    somarrenda(Renda),
    retract(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    assertz(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)).
relatorio:-
    retract(ranual(A)),
    assert(ranual(0)),
    format('Renda Anual Total ~w: ',[A]).

rel_depend(CPF):-
    retract(dependente(CPF,Nome1,Idade1,Genero1)),
    somar,
    format('Dependente: ~w Idade: ~w Genero: ~w ~n',[Nome1,Idade1,Genero1]),
    retract(dependente(CPF,Nome1,Idade1,Genero1)),
    asserta(dependente(CPF,Nome1,Idade1,Genero1)).

rel_depend(CPF):-
    retract(soma(A)),
    assert(soma(0)),
    T is 1200*A,
    format('IPRF do ~w: ~w',[CPF,T]),
    nl,
    nl.
somarrenda(X):-
    retract(ranual(Y)),
    T is Y + X,
    assert(ranual(T)).
somar:-
    retract(soma(X)),
    T is X + 1,
    assert(soma(T)).
somaT:-
    retract(total(Y)),
    T is Y + 1,
    assert(total(T)).
somarD:-
    retract(dependente(Cpf,Nome,Idade,Genero)),
    somaT,
    retract(dependente(Cpf,Nome,Idade,Genero)),
    asserta(dependente(Cpf,Nome,Idade,Genero)).

debug_load :-
    open('contribuintes.txt',append,Stream1,[create([read,write,execute])]),
    close(Stream1),
    open('dependentes.txt',append,Stream2,[create([read,write,execute])]),
    close(Stream2).
