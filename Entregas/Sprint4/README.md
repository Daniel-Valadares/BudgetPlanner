# Introdução

Este projeto está sendo desenvolvido como parte do curso de Laboratório de Dispositivos Móveis (LDDM) da PUC Minas - Campus Coração Eucarístico, com o objetivo de proporcionar uma introdução à programação mobile.

# Integrantes da Equipe

A equipe responsável pelo projeto é composta pelos seguintes alunos:

* Caio Henrique Alvarenga Gonçalves
* Daniel Valadares de Souza Felix
* Felipe Augusto Maciel Constantino

# Objetivo da Sprint

Nesta Sprint, nosso objetivo era finalizar o projeto da disciplina. Fazendo uma revisão em todos os Sprints entreguem. Durante essa Sprint, todas as partes foram responsáveis de finalizar correções de pendencias passadas, e finalizar o projeto, conforme as necessidades do mesmo.

# Projeto do Banco de Dados

Usamos como base para nosso Banco de Dados o protótipo que criamos durante a [Sprint 1](https://github.com/Daniel-Valadares/BudgetPlanner/tree/main/Entregas/Sprint1). Com mais entendimento de nosso projeto, e maior entendimento do escopo, algumas pequenas modificações foram realizadas, para a devida concepção do projeto de Banco de Dados. Após algumas reuniões, o seguinte Projeto de Banco de Dados utilizando o SQLite foi definido: 

![BancoDados](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/img/BancoDados.png)

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

# Telas da Aplicação

Seguimos o modelo dos Wireframes da [Sprint 1](https://github.com/Daniel-Valadares/BudgetPlanner/tree/main/Entregas/Sprint1) para realizar as telas. Entretanto, a medida em que confeccionamos as telas, extrapolamos um pouco o Wireframe, para melhor acomodar futuras necessidades do projeto, e evitar redundância. Resultando assim nas seguintes telas

## Tela Principal

Essa página, da acesso ao usuário a funcionalidade principal da aplicação, as estatísticas de sua relação de gastos.

**Tela Principal:**

![Tela Principal](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/img/TelaPrincipal.png)

## Tela Transações

Essa página, da acesso aos dados financeiros registrados pelo usuário, além de permitir registrar novos dados.

**Tela Transações:**

![Tela Transações](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/img/TelaTransacoes.png)

## Tela Perfil

 Essa página, da acesso a pagina de usuário, ao mesmo tempo que permite mudar configurações gerais da conta do usuário.

**Tela Perfil:**

![Tela Perfil](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/img/TelaPerfil.png)

## Tela Sign-In

Essa página, permite os usuários de acessarem suas contas, para usufruir dos recursos da aplicação.

**Tela Sign-In:**

![Tela Sign-In](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/img/TelaSignIn.png)

## Tela Sign-Up

Essa página, permite os usuários de criarem suas contas, para usufruir dos recursos da aplicação.

**Tela Sign-Up:**

![Tela Sign-Up](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/img/TelaSignUp.png)

## Tela Configurações 

 Essa página, da acesso ao um menu de configurações para definir as preferencias da aplicação, e customizar a experiencia do usuário.

**Tela Configurações:**

![Tela Configurações](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/img/TelaConfiguracoes.png)

## Tela Sobre 

 Essa página, da acesso a uma tela que exibe os direitos autorias da aplicação.

**Tela Sobre:**

![Tela Sobre](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/img/TelaSobre.png)

# Demonstração do App

Para testar ao CRUD, basta acessar a pasta [Codigo](https://github.com/Daniel-Valadares/BudgetPlanner/blob/main/Entregas/Sprint4/Codigo), e utilizando o Android Studio, realizar os testes de forma manual.