% exemplo de diretorio: C:\\Users\\Eduardo\\Desktop\\PUc\\PROLOG\\dependentes.txt

:- dynamic dependente/4.
:- dynamic contribuinte/11.
:- dynamic soma/1.
:- dynamic ranual/1.
:- dynamic total/1.

rf:-
    assertz(valor(0)),
    retractall(ranual(_)),
    assert(ranual(0)),
    retractall(total(_)),
    assert(total(0)),
    retractall(soma(_)),
    assert(soma(0)),
    write('\e[23'),
    nl,
    write('======================================================================='),nl,
    write('=                            Receita Federal                          ='),nl,
    write('======================================================================='),nl,
    write('| 1- Incluir Contribuinte                                             |'),nl,
    write('| 2- Incluir Dependente                                               |'),nl,
    write('| 3- Localizar Contribuinte pelo CPF                                  |'),nl,
    write('| 4- Excluir contribuinte e seus Dependentes da Memoria               |'),nl,
    write('| 5- Excluir contribuinte e seus Dependentes do Arquivo e Memoria     |'),nl,
    write('| 6- Relatorio de Contribuintes                                       |'),nl,
    write('| 7- Total de Dependentes por Contribuinte                            |'),nl,
    write('| 8- Salvar os Dados em um arquivo                                    |'),nl,
    write('| 9- Carregar os Dados do Arquivo                                     |'),nl,
    write('| 10- Excluir Dados da Memoria                                        |'),nl,
    write('| 11- Excluir Dados do Aquirvo                                        |'),nl,
    write('| 0- Sair                                                             |'),nl,
    write('======================================================================='),nl,
    write('Informe uma das opcoes abaixo: '),
    read(Op),
    Op=\=0,
    executa(Op),
    rf.

executa(1):-
    write('Digite o CPF: '),
    read(CPF),
    not(check_cont(CPF)),
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
    not(check_dependente(CPF)),
    input(Nome,Idade,Genero),
    create_dependente(CPF,Nome,Idade,Genero).
executa(3):-
    write('Digite o CPF: '),
    read(CPF),
    not(check_dependente(CPF)),
    not(procurar(CPF)).

executa(4):-
    write('Digite o CPF: '),
    read(CPF),
    excluir_cpf_memoria(CPF).
executa(5):-
    write('Digite o CPF: '),
    read(CPF),
    excluir_Cpf_arquivo(CPF).
executa(6):-
    relatorio.
executa(7):-
    retractall(total(_)),
    assert(total(0)),
    somarD().
executa(8):-
    save,
    writeln("Contribuintes e Dependentes Salvos!").

executa(9):-
    carregar_contribuintes,
    carregar_dependentes,
    write('Carregando arquivos...').

executa(10):-
    excluir_dados.

executa(11):-
    delete_file('C:\\SEU-DIRETORIO\\dependentes.txt'),
    delete_file('C:\\SEU-DIRETORIO\\contribuintes.txt').

carregar_contribuintes:-
    consult('C:\\SEU-DIRETORIO\\contribuintes.txt').

carregar_dependentes:-
    consult('C:\\SEU-DIRETORIO\\dependentes.txt').


procurar(CPF):-
    writeln(' '),
    writeln('Dados do Contribuinte: '),
    contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular),
    tab(4),
    write('CPF: '),
    write(CPF),nl,
    tab(4),
    write('Nome: '),
    write(Nome),nl,
    tab(4),
    write('Genero: '),
    write(Genero),nl,
    tab(4),
    write('Renda: '),
    write(Renda),nl,
    tab(4),
    write('Logradouro: '),
    write(Log),nl,
    tab(4),
    write('Numero: '),
    write(Num),nl,
    tab(4),
    write('Complemento: '),
    write(Comple),nl,
    tab(4),
    write('Cidade: '),
    write(Cidade),nl,
    tab(4),
    write('Estado: '),
    write(Estado),nl,
    tab(4),
    write('CEP: '),
    write(CEP),nl,
    tab(4),
    write('Celular: '),
    write(Celular),nl,
    tab(4),
    fail.
procurar(CPF):-
    writeln(' '),
    writeln('Dados dos Dependentes: '),
    dependente(CPF,Nome,Idade,Genero),
    tab(4),
    write('Nome: '),
    write(Nome),nl,
    tab(4),
    write('Idade: '),
    write(Idade),nl,
    tab(4),
    write('Genero: '),
    write(Genero),nl,
    tab(4),
    nl,
    retract(dependente(CPF,Nome,Idade,Genero)),
    assertz(dependente(CPF,Nome,Idade,Genero)),
    fail.
check_cont(CPF):-
    contribuinte(CPF,_,_,_,_,_,_,_,_,_,_),
    writeln("Verifique Se Voce Tem Algum Contribuinte Com Este CPF Salvo!").
check_dependente(CPF):-
    not(contribuinte(CPF,_,_,_,_,_,_,_,_,_,_)),
    writeln("Verifique Se Voce Tem Algum Contribuinte Com Este CPF Salvo!").
create_dependente(CPF,Nome,Idade,Genero):-
    contribuinte(CPF,_,_,_,_,_,_,_,_,_,_),
    asserta(dependente(CPF,Nome,Idade,Genero)).
create_contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular):-
    asserta(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)).

save :-
    not(save_dependentes),
    not(save_contribuintes).
save_dependentes:-
    dependente(CPF,Nome,Idade,Genero),
    open('C:\\SEU-DIRETORIO\\dependentes.txt',append,Stream,[create([read,write,execute])]),
    write(Stream,dependente(CPF,Nome,Idade,Genero)),
    write(Stream,.),
    nl(Stream),
    close(Stream),
    retract(dependente(CPF,Nome,Idade,Genero)),
    assertz(dependente(CPF,Nome,Idade,Genero)),
    fail.

save_contribuintes :-
    contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular),
    open('C:\\SEU-DIRETORIO\\contribuintes.txt',append,Stream2,[create([read,write,execute])]),
    write(Stream2,contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    write(Stream2,.),
    nl(Stream2),
    close(Stream2),
    retract(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    assertz(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    fail.

excluir_contribuinte_arquivo() :-
    delete_file('C:\\SEU-DIRETORIO\\contribuintes.txt'),
    contribuinte(CPf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular),
    open('C:\\SEU-DIRETORIO\\contribuintes.txt',append,Stream,[create([read,write,execute])]),
    write(Stream,contribuinte(CPf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    write(Stream,.),
    nl(Stream),
    close(Stream),
    retract(contribuinte(CPf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    assertz(contribuinte(CPf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    fail.

excluir_dependente_arquivo():-
    delete_file('C:\\SEU-DIRETORIO\\dependentes.txt'),
    dependente(CPf,Nome,Idade,Genero),
    open('dependentes.txt',append,Stream,[create([read,write,execute])]),
    write(Stream,dependente(CPf,Nome,Idade,Genero)),
    write(Stream,.),
    nl(Stream),
    close(Stream),
    retract(dependente(CPf,Nome,Idade,Genero)),
    assertz(dependente(CPf,Nome,Idade,Genero)),
    fail.

excluir_Cpf_arquivo(CPF):-
    excluir_cpf_memoria(CPF),
    not(excluir_contribuinte_arquivo()),
    not(excluir_dependente_arquivo()).
excluir_cpf_memoria(CPF) :-
    retractall(dependente(CPF,_,_,_)),
    retract(contribuinte(CPF,_,_,_,_,_,_,_,_,_,_)).
excluir_arquivo:-
    delete_file('C:\\SEU-DIRETORIO\\contribuintes.txt'),
    delete_file('C:\\SEU-DIRETORIO\\dependentes.txt'),
    open('C:\\SEU-DIRETORIO\\contribuintes.txt',append,Stream1,[create([read,write,execute])]),
    close(Stream1),
    open('C:\\SEU-DIRETORIO\\dependentes.txt',append,Stream2,[create([read,write,execute])]),
    close(Stream2).

excluir_dados:-
    retractall(contribuinte(_,_,_,_,_,_,_,_,_,_,_)),
    retractall(dependente(_,_,_,_)).
input(Nome,Idade,Genero):-
    write('Digite o Nome: '),
    read(Nome),
    write('Digite o Idade: '),
    read(Idade),
    write('Digite o Genero: '),
    read(Genero).
relatorio:-
    contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular),
    format('Contribuinte: ~w ~n CPF: ~w, Genero: ~w, Renda: ~w ~n Log: ~w, Comple: ~w, Cidade: ~w ~n Estado: ~w, CEP: ~w, Celular: ~w ~n',[Nome,CPF,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular]),
    rel_depend(CPF),
    somarrenda(Renda),
    retract(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    assertz(contribuinte(CPF,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,CEP,Celular)),
    fail.
relatorio:-
    retract(ranual(A)),
    assert(ranual(0)),
    format('Renda Anual Total ~w: ',[A]).

rel_depend(CPF):-
    dependente(CPF,Nome1,Idade1,Genero1),
    somar,
    format('Dependente: ~w Idade: ~w Genero: ~w ~n',[Nome1,Idade1,Genero1]),
    retract(dependente(CPF,Nome1,Idade1,Genero1)),
    asserta(dependente(CPF,Nome1,Idade1,Genero1)),
    fail.

rel_depend(CPF):-
    retract(soma(A)),
    assert(soma(0)),
    T is 1200*A,
    format('IPRF do ~w: ~w',[CPF,T]),
    nl,
    nl.
somarrenda(X):-
    retract(ranual(Y)),
    T is Y + (X*12),
    assert(ranual(T)).
somar:-
    soma(X),
    T is X + 1,
    retract(soma(X)),
    assertz(soma(T)).
somaT(Cpf):-
    dependente(Cpf,Nome1,Idade1,Genero1),
    retract(total(Y)),
    T is Y + 1,
    assertz(total(T)),
    retract(dependente(Cpf,Nome1,Idade1,Genero1)),
    asserta(dependente(Cpf,Nome1,Idade1,Genero1)),
    fail.
somaT(Cpf):-
    retract(total(X)),
    assertz(total(0)),
    format('Cpf: ~w Numero de dependentes: ~w',[Cpf,X]),nl.

somarD():-
    contribuinte(Cpf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,Cep,Celular),
    somaT(Cpf),
    retract(contribuinte(Cpf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,Cep,Celular)),
    asserta(contribuinte(Cpf,Nome,Genero,Renda,Log,Num,Comple,Cidade,Estado,Cep,Celular)),
    fail.
somarD():-
    nl.


