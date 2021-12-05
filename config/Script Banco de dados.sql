Create database exemplo;

use exemplo;
create table usuarios(
id  int auto_increment primary key,
nome varchar (50),
usuario varchar (50),
senha varchar (50)
);

create table funcionario (
id int auto_increment primary key,
nome varchar (50),
endereco varchar (50),
Bairro  Varchar (50),
Funcao Varchar (50),
Salario varchar(50)
);

create table produto (
id int auto_increment primary key,
nomeProduto varchar (50),
Valor varchar (10),
Quantidade varchar (10)
);

create table Estado (
id int auto_increment primary key,
nome varchar (50),
sigla varchar (10)
);
Insert into usuarios (nome, usuario, senha ) values ("teste", "teste","123");
