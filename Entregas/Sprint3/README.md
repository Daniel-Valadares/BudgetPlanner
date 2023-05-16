# Introdução

Este projeto está sendo desenvolvido como parte do curso de Laboratório de Dispositivos Móveis (LDDM) da PUC Minas - Campus Coração Eucarístico, com o objetivo de proporcionar uma introdução à programação mobile.

# Integrantes da Equipe

A equipe responsável pelo projeto é composta pelos seguintes alunos:

* Caio Henrique Alvarenga Gonçalves
* Daniel Valadares de Souza Felix
* Felipe Augusto Maciel Constantino

# Objetivo da Sprint

Nesta Sprint, nosso objetivo é entregar o projeto do banco de dados e a integração desse banco de dados com as operações CRUD no aplicativo BudgetPlanner. Para alcançar esses objetivos, dividimos as tarefas entre os membros da equipe da seguinte maneira:

* Documentação: Daniel
* Implementação do Banco de Dados em SQLite: Caio e Felipe
* Implementação dos Métodos no APP: Todos
* Modificações do APP e Padronização: Daniel e Felipe
* Principais Métodos CRUD: Caio
* Projeto do Banco de Dados: Todos

Com essa divisão, demos início à confecção da tarefa e, para maximizar a produtividade, dividimos o grupo em diferentes funções, conforme demonstrado nos tópicos acima, e no Grafo abaixo:

![Divisao](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint3/img/Divisao.png)

# Projeto do Banco de Dados

Usamos como base para nosso Banco de Dados o protótipo que criamos durante a [Sprint 1](https://github.com/Daniel-Valadares/BudgetPlanner/tree/main/Entregas/Sprint1). Com mais entendimento de nosso projeto, e maior entendimento do escopo, algumas pequenas modificações foram realizadas, para a devida concepção do projeto de Banco de Dados. Após algumas reuniões, o seguinte Projeto de Banco de Dados utilizando o SQLite foi definido: 

![BancoDados](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint3/img/BancoDados.png)

Com essa estruturação adequada, garantimos que todas as necessidades do aplicativo serão atendidas. A seguir, apresentamos uma explicação detalhada de cada entidade do banco de dados:

## Usuário

O objeto "Usuário" representa as contas dos usuários e serve como base para o devido cadastro. Os atributos escolhidos para esse objeto são:

* INTERGER id: Variável para identificação da conta, usada em processos internos de CRUD do APP
* TEXT nome: Variável para identificação do nome do Usuário
* TEXT email: Variável para identificação do nome do Usuário
* TEXT senha: Variável para identificação da senha do Usuário, a qual é salva no Banco de Dados utilizando o método de criptografia MD5, encontrado no package [Crypto](https://pub.dev/packages/crypto) da linguagem Flutter, e publicado no site [pub.dev](https://pub.dev).

## Bancos

O objeto "Bancos" serve como base para os cálculos do aplicativo, recebendo dados não confidenciais sobre a conta bancária. Através desse objeto, é possível criar objetos de cartão e transações. Os atributos escolhidos para esse objeto são:

* INTERGER id: Variável para identificação da conta bancaria, usada em processos internos de CRUD do APP
* TEXT nome: Variável para identificação do nome do Banco que abriga a conta.
* REAL saldo: Variável para identificação do saldo atual da Conta Bancaria.
* INTERGER idUsuario: Variável para devida identificação do Usuário detentor da Conta Bancaria.

## Cartão

O objeto "Cartão" representa os cartões, sejam de crédito ou débito, existentes em uma determinada conta bancária. Essa entidade desempenha um papel fundamental para os dados estatísticos retornados pelo aplicativo. Os atributos escolhidos para esse objeto são:

* INTERGER id: Variável para identificação do cartão, usada em processos internos de CRUD do APP
* TEXT nome: Variável para identificação de um nome a escolha do usuário para um cartão registrado
* TEXT tag: Variável para identificação do tipo de cartão (Credito, Debito e outros)
* INTERGER isInternacional: Variável boolean, salva como integer devido a limitação da datatype do SQLite. Representa se o cartão é ou não é internacional, sendo suas representado, respetivamente, por 1 e 0.
* INTERGER idBanco: Variável para devida identificação de Banco detentor do Cartão.

## Transações

O objeto "Transações" representa as transações realizadas por uma conta bancária, podendo ou não estar relacionadas a um cartão. Os atributos escolhidos para esse objeto são:

* INTERGER id: Variável para identificação da transferência, usada em processos internos de CRUD do APP
* REAL valor: Variável para identificação do valor de determinada transferência
* TEXT timeStamp: Variável para identificação do devido horário de certa transferência
* TEXT metodo: Variável para identificação do tipo de transação e seus subtipos (Ex: Recebimento - Transferência, Recebimento - Pagamento, Saida - Transferência, entre outros).
* INTERGER idBanco: Variável para devida identificação de Banco detentor da transferência.
* INTERGER idCartao: Variável para devida identificação de Cartão para caso um cartão tenha sido utilizado na transação. Caso nenhum cartão tenha sido utilizado, o valor será definido como 0, já que o SQLite com a funcionalidade de auto incrementação do SQLite, jamais cria um id 0.

# Integração do Banco de Dados com operações CRUD no APP

Para esse Sprint, foi requirido que fosse criado as principais entidades no aplicativo. Que no caso se da pela entidade "Usuário". Para cumprir tal tarefa, foi pedido a Caio estudar alguns algoritmos exemplos, e adapta-lós para o projeto; onde o resultado pode ser visto na pasta [CRUD_teste](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint3/CRUD_teste).

Após isso, o grupo se uniu para realizar todas os métodos CRUDs vitais, e outros de relevância menor, porém ainda assim relevantes para a aplicação. Após a finalização das Tarefas acima, o grupo se juntou para a realização da integração com o BudgetPlanner. E após atingir resultado satisfatório, passamos por um momento para organizar e aprimorar o código.  

# Demonstração do App

Para testar ao CRUD, basta acessar a pasta [Codigo](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint3/Codigo), e utilizando o Android Studio, realizar os testes de forma manual.