DROP TABLE IF EXISTS funcionario, funcionario_atendente, funcionario_mecanico,  especialidade, mecanico_tem_especialidade, ferramenta
, mecanico_utiliza_ferramenta, reparo, pedido, cliente, peca, tipo, equipamento, reparo_equipamento, ferramenta_peca;

create table funcionario(
CPF varchar(11),
nome varchar(100),
salario decimal,
primary key(CPF)
);

create table funcionario_atendente(
CPF_a char(11),
telefone_comercial_a varchar(11),
horario_atendimento time,
login_a varchar(20),
primary key(CPF_a),
foreign key(CPF_a) references funcionario(CPF) on delete cascade on update cascade

);

create table funcionario_mecanico(
CPF_m char(11),
comissao decimal,
endereco_m varchar(100),
experiencia varchar(100),
primary key(CPF_m),
foreign key(CPF_m) references funcionario(CPF) on delete cascade on update cascade

);

create table especialidade(
ID_esp integer,
nome varchar(50),
descricao_esp varchar(150),
primary key(ID_esp)
);

create table mecanico_tem_especialidade(
CPF_mec char(11) not null,
ID_esp integer not null,
primary key(CPF_mec, ID_esp),
foreign key(CPF_mec) references funcionario_mecanico(CPF_m),
foreign key(ID_esp) references especialidade(ID_esp)
);

create table ferramenta(
ID_ferramenta integer,
qtde integer,
nome varchar(100),
primary key(ID_ferramenta)
);

create table mecanico_utiliza_ferramenta(
ID_F integer,
CPF_mec char(11),
primary key(ID_F, CPF_mec),
foreign key(ID_F) references ferramenta(ID_ferramenta),
foreign key(CPF_mec) references funcionario_mecanico(CPF_m) 
);

create table reparo(
ID integer,
valor decimal,
dia date,
CPF_mecanico char(11) not null,
primary key(ID),
foreign key(CPF_mecanico) references funcionario_mecanico(CPF_m) 
);

create table cliente(
CPF_c char(11),
nome varchar(100),
endereco_c varchar(100),
primary key(CPF_c)
);

create table pedido(
ID integer,
descricao varchar(150),
dia date,
CPF_atendente char(11) not null,
CPF_cliente char(11) not null,
primary key(ID),
foreign key(CPF_atendente) references funcionario_atendente(CPF_a),
foreign key(CPF_cliente) references cliente(CPF_c)
);

create table peca(
ID_p integer,
valor decimal,
descricao varchar(100),
qtde integer,
ID_reparo integer,
primary key(ID_p),
foreign key(ID_reparo) references reparo(ID)
);

create table tipo(
ID integer,
nome varchar(100),
descricao varchar(200),
primary key(ID)
);

create table equipamento(
ID_equi integer, 
marca varchar(100),
funcionalidade varchar(200),
CPF_cliente char(11) not null,
ID_tipo integer not null,
primary key(ID_equi),
foreign key(CPF_cliente) references cliente(CPF_c),
foreign key(ID_tipo) references tipo(ID)
);

create table reparo_equipamento(
ID_equipamento integer,
ID_reparo integer,
primary key(ID_equipamento, ID_reparo),
foreign key(ID_equipamento) references equipamento(ID_equi),
foreign key(ID_reparo) references reparo(ID)
);