-- https://github.com/amandaferrari20/Banco-de-dados-1/edit/main/ConsultaMecania/mec.sql
DROP TABLE IF EXISTS funcionario, funcionario_atendente, funcionario_mecanico,  especialidade, mecanico_tem_especialidade, ferramenta
, mecanico_utiliza_ferramenta, reparo, pedido, cliente_mecanica, peca, tipo, equipamento, reparo_equipamento, ferramenta_peca;

create table funcionario(
CPF varchar(15),
nome varchar(100),
salario decimal,
primary key(CPF)
);

create table funcionario_atendente(
CPF_a varchar(15),
telefone_comercial_a varchar(15),
horario_atendimento_entrada time,
horario_atendimento_saida time,
login_a varchar(20),
primary key(CPF_a),
 foreign key(CPF_a) references funcionario(CPF) 
 on delete cascade on update cascade
);

create table funcionario_mecanico(
CPF_m char(15),
comissao varchar(5),
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
CPF_mec char(15) not null,
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
CPF_mec char(15),
primary key(ID_F, CPF_mec),
foreign key(ID_F) references ferramenta(ID_ferramenta),
foreign key(CPF_mec) references funcionario_mecanico(CPF_m) 
);

create table reparo(
ID integer,
valor decimal,
dia date,
CPF_mecanico char(15) not null,
primary key(ID),
foreign key(CPF_mecanico) references funcionario_mecanico(CPF_m) 
);

create table cliente_mecanica(
CPF_c char(15),
nome varchar(100),
endereco_c varchar(100),
primary key(CPF_c)
);

create table pedido(
ID integer,
descricao varchar(150),
dia date,
CPF_atendente char(15) not null,
CPF_cliente char(15) not null,
primary key(ID),
foreign key(CPF_atendente) references funcionario_atendente(CPF_a),
foreign key(CPF_cliente) references cliente_mecanica(CPF_c)
);

create table peca(
ID_p integer,
valor decimal,
descricao varchar(300),
qtde integer,
ID_reparo integer,
primary key(ID_p),
foreign key(ID_reparo) references reparo(ID)
);

create table tipo(
ID integer,
nome varchar(100),
descricao varchar(400),
primary key(ID)
);

create table equipamento(
ID_equi integer, 
marca varchar(100),
funcionalidade varchar(200),
CPF_cliente char(15) not null,
ID_tipo integer not null,
primary key(ID_equi),
foreign key(CPF_cliente) references cliente_mecanica(CPF_c),
foreign key(ID_tipo) references tipo(ID)
);

create table reparo_equipamento(
ID_equipamento integer,
ID_reparo integer,
primary key(ID_equipamento, ID_reparo),
foreign key(ID_equipamento) references equipamento(ID_equi),
foreign key(ID_reparo) references reparo(ID)
);

insert into funcionario values('124.395.758-10', 'Vannessa Jalbert', 1192),
('473.861.334-05', 'Diego Oliveira', 1188), ('106.766.158-13', 'Kai Oliveira', 1568), 
('683.034.905-24', 'Nicolash Castro', 1299), ('978.770.968-79', 'Vitória Goncalves', 1953),
('482.106.863-05', 'Tiago Melo', 1450), ('561.320.288-54', 'Beatriz Gomes', 2450),
('625.318.159-96', 'Bianca Pinto', 1192),('398.633.123-98', 'Daniel Gomes', 1811), 
('207.762.332-20', 'João Cunha', 2708);

insert into funcionario values('450.194.829-94','Thaís Barros',2750),
('331.351.556-84','Ana Dias',2557), ('633.698.287-40','Thiago Cardoso',2100),
('946.225.049-95','Gustavo Melo',2300),('381.105.144-05','Mateus Silva',2557),
('840.471.147-07','Clara Rocha',1970),('217.113.051-20','Gabrielle Cardoso',2360),
('634.244.970-88', 'Lucas Pereira',1700),('322.545.869-47','Luís Melo',1900),
('118.452.131-06','Samuel Azevedo',1450);

insert into funcionario_mecanico values('450.194.829-94', '8%', 'CEP:88058-772 - Rua Francisca da Glória 1905','motosserras e semelhantes'),
('331.351.556-84', '3%', 'CEP:81150-020 - Rua Aref Kudri 1282','motosserras STIHL'),
('633.698.287-40', '5%', 'CEP:69313-000 - Avenida I 208','cortador de grama'),
('946.225.049-95', '3%', 'CEP:53417-120 - Rua Belo Jardim 421','motores'),
('381.105.144-05', '5%', 'CEP:58040-630 - Rua Conselheiro Odilon do Egito 1576','motosserra MAKITA'),
('840.471.147-07', '8%', 'CEP:13034-510 - Rua Doutor Paulo Florence 1869','motosserras e semelhantes'),
('217.113.051-20', '7%', 'CEP:74860-215 - Rua Uaxito 211','motosserras a gasolina'),
('634.244.970-88', '7%', 'CEP:30460-150 - Rua Camélias 1730','roçadeira'),
('322.545.869-47', '5%', 'CEP:74477-309 - Rua BS 15 C 699','motor dois tempos'),
('118.452.131-06', '7%', 'CEP:06540-305 - Alameda Corimbatá 746','cortador de grama');

insert into funcionario_atendente values('124.395.758-10', '(44) 9986-9213','09:00:00','17:00:00','jabref234'),
('473.861.334-05', '(45) 9076-4917','09:00:00','17:00:00','Dausitherer'),
('106.766.158-13', '(81) 9875-7856','09:00:00','17:00:00','Spitilod'),
('683.034.905-24', '(62) 9995-8688','09:00:00','17:00:00','Eing2018'),
('978.770.968-79', '(15) 9647-2433','09:00:00','17:00:00','Seesculde'),
('482.106.863-05', '(44) 9808-9644','09:00:00','17:00:00','Samphy'),
('561.320.288-54', '(11) 9943-6635','09:00:00','17:00:00','Thicia456'),
('625.318.159-96', '(51) 9749-9143','09:00:00','17:00:00','Veamel'),
('398.633.123-98', '(44) 9967-7073','09:00:00','17:00:00','Penver'),
('207.762.332-20', '(44) 9826-4506','09:00:00','17:00:00','Farnews');

insert into especialidade values(1,'Técnico de Máquinas','Esta especialidade engloba todas
contendo peças que compoem um motosserra de todos os tipos.'),
(2,'motosserras STIHL', 'Esta especialidade exige que o mecanico tenha total conhecimento do
funcinamento dos motosserras da marca STIHL'),
(3,'Manutenção de Máquinas Cortadoras de Grama','Esta especialidade é sobre o
conhecimento em maquinas de cortar grama e a manutenção da mesma'),
(4,'Mecânico de Manutenção de Roçadeiras','Conhecimento em maquinas roçadeiras e a manutenção'),
(5,'Manutenção de motores dois tempos','Nesta especialidade o mecanico tem que ter total
conhecimento de motores dois tempos e suas funcionalidades'),
(6,'Manutenção de motores','Conhecimento na area de motores em geral'),
(7,'Manutenção em máquinas MAKITA','Conhecimento nas peças para motosserras e semelhantes da marca MAKITA e seu funcionamento'),
(8,'Manutenção de motosserras a gasolina','Conhecimento geral em motosserras que funcionam a gasolina'),
(9,'Manutenção de motosseras a bateria','Conhecimento geral em motosserras que funcionam a bateria'),
(10, 'Manutenção de máquinas Branco','Conhecimento nas peças para motosseras e semelhantes da marca Branco e seu funcionamento');

 insert into mecanico_tem_especialidade values('450.194.829-94',1),('331.351.556-84',2),
 ('633.698.287-40',3),('946.225.049-95',6),('381.105.144-05',7),('840.471.147-07',1),
 ('331.351.556-84',7),('217.113.051-20',8),('634.244.970-88',4),('322.545.869-47',5),('118.452.131-06',3),
 ('118.452.131-06',10),('118.452.131-06',9);
 
 insert into ferramenta values(1,10,'3/16" lima redonda de dentes finos'),
 (2,5,'5/32 “dente fino redondo arquivo'), (3,2,'ferramenta de medidor de profundidade'),
 (4,9,'6" Arquivo de dente fino plano'),(5,8,'3/8 “Mancha de madeira e alça de acabamento'),
 (6,3,'Trava Para Desmontar Filtro Centrifugo Da Honda Pequena'),(7,6,'Chave extratora tampa para manutençao em suspensão RST'),
 (8,10,'Chave Regulagem Carburador Husqvarna 136/142/235/236e'),
 (9, 4, 'Ferramentas De Remoção De Embreagem U'),(10, 2, 'Afiador Corrente Motosserra Profissional 85w Motor Indução'),
 (11,3,'Kit chaves combinadas de 12 a 22mm');
 
 insert into mecanico_utiliza_ferramenta values(1,'450.194.829-94'),(3,'450.194.829-94'),
 (10, '450.194.829-94'),(11, '450.194.829-94'),(11,'331.351.556-84'),(9,'633.698.287-40'),
 (8,'946.225.049-95'),(7,'381.105.144-05'),(2,'840.471.147-07'),(3,'217.113.051-20'),
 (6,'634.244.970-88'),(4,'322.545.869-47'),(5,'118.452.131-06');
 
insert into reparo values(1,700,'2022-03-09','450.194.829-94'),
(2,199,'2022-03-10','331.351.556-84'),(3,594,'2022-03-10','633.698.287-40'),
(4,50,'2022-03-11','946.225.049-95'),(5,110,'2022-03-11','381.105.144-05'),
(6,225,'2022-03-12','840.471.147-07'),(7,75,'2022-03-12','217.113.051-20'),
(8,398,'2022-03-14','634.244.970-88'),(9,1200,'2022-03-15','322.545.869-47'),
(10,569,'2022-03-15','118.452.131-06');
 
 insert into cliente_mecanica values('568.182.718-63','Thiago Barros','CEP:07143-153 - Rua Álvaro Luís Ferreira Santos 975'),
 ('756.993.633-78','Sophia Rodrigues','CEP:29179-200 - Rua Sucupira Preta 1374'),
 ('486.289.926-93','Caio Alves','CEP:21825-275 - Rua Itacarambi 273'),
 ('893.659.579-23','Amanda Almeida','CEP:07178-060 - Rua Ipiranga do Piauí 851'),
 ('795.536.596-83','Vitór Barros','CEP:68510-080 - Quadra Onze 1860'),
 ('861.507.995-14','Diego Azevedo','CEP:25802-255 - Travessa Jorge Barreto 840'),
 ('662.147.522-54','Julieta Rodrigues','CEP:66060-085 - Vila Fátima 892'),
 ('541.143.106-90','Lara Gomes','CEP:26341-360 - Rua Comandante Rocha 842'),
 ('808.126.389-64','Leila Martins','CEP:13221-800 - Avenida Marginal Rio Jundiaí 1517'),
 ('655.654.797-20','Vitória Cardoso','CEP:81920-560 - Rua Alvir Teixeira dos Santos 534');
 
 insert into pedido values(1,'Trocar carburador','2022-02-01','124.395.758-10','568.182.718-63'),
 (2,'Afiar correntes e revisar','2022-02-01','473.861.334-05','756.993.633-78'),
 (3,'Revisar, está parando de funcionar após cerca de 2 minutos consecutivos ligado','2022-02-02','106.766.158-13','486.289.926-93'),
 (4,'Sabre quebrado','2022-02-02','683.034.905-24','893.659.579-23'),
 (5,'Revisão','2022-02-03','978.770.968-79','795.536.596-83'),
 (6,'Vela queimada','2022-02-03','482.106.863-05','861.507.995-14'),
 (7,'Trocar corrente','2022-02-03','561.320.288-54','662.147.522-54'),
 (8,'Roçadeira esquenta e desliga','2022-02-04','625.318.159-96','541.143.106-90'),
 (9,'Roçadeira saindo fumaça','2022-02-04','398.633.123-98','808.126.389-64'),
 (10,'Lâminas danificadas','2022-02-05','207.762.332-20','655.654.797-20');
 
 insert into peca values(1,155, 'Carburador Motosserras MS 170/180 Stihl -
Indicada para Motosserras Modelos MS170/180 - Cód. Fabricante: 1130-120-0606 - Marca: STIHL ORIGINAL',1,1),
(2,130,'Corrente para Motosserra CARLTON 3/8" 36 Dentes',1,2),
(3,60,'Velas De Ignição Sthil Motosserra Roçadeira - Mammut',2,3),
(4,300,'Sabre Stihl Motosserra Ms 380/381/382 40cm 30 Facas',1,4),
(5,65,'Disco Para Roçadeira Com Dentes De Corrente Motosserra',1,5),
(6,130,'Corrente para Motosserra CARLTON 3/8" 36 Dentes',1,7),
(7,20,'Velas De Ignição para Motosserra ou Roçadeira 2t',1,6),
(8,120,'Carburador Para Roçadeira Stihl Fs160 Fs220 Fs280 Fr220', 1,8),
(9,128,'Ponteira Transmissão Para Roçadeira 9 Estrias Tubo 28mm',1,9),
(10,30,'Corrente Para Motosserra Tekna 16 Pol 32 Dentes 0,325 1,5mm',1,10);
 
insert into tipo values(1,'Motosserra a Gasolina','O tanque de gasolina típico contém cerca de 0,5 litro
 de óleo para motosserra. Depois de inserir o combustível, ele passará pelo carburador, onde 
 realmente se mistura com o ar. A mistura ar-combustível é então transferida para o cilindro'),
 (2,'Motosserra a bateria','Equipamento mais leve, silencioso e que não emite odores'),
 (3,'Aparador de grama','Corta o que os cortadores de grama deixam para trás'),
 (4, 'Cortador de grama manual','Máquina usada para cortar a grama em jardins, campos 
 esportivos ou qualquer terreno para que a superfície esteja a uma altura regular'),
 (5,'Cortador de grama gasolina','Equipamento robusto usado para aparar os pequenos e finos matos verdes,
 conhecidos popularmente como grama'),
 (6,'Roçadeira a gasolina','A utilização da roçadeira torna o trabalho muito mais eficiente, 
 rápido e com menos esforço.Possui autonomia para 60minutos em rotação máxima'),
 (7,'Roçadeira lateral a gasolina','máquina com motor de boa potência, normalmente composta por motores de 2 tempos'),
 (8,'Roçadeira lateral eletrica','A vantagem da roçadeira é que pode ser usada em locais irregulares, 
 morros, buracos, florestas. Em locais extremamente planos e extensos, recomenda-se a utilização de cortadores de grama'),
 (9,'Kart cross motosserra','Variante do automobilismo sobre veículos simples, de quatro rodas'),
 (10, 'Patinete com motor de motosserra','Geralmente modificado, mais eficiente'),
 (11, 'Semelhantes','Tipo utilizado para atribuir a maquinas que tenham semelhança de peças
 de motosserra e roçadeira');

 insert into equipamento values(1,'STIHL','Utilizadas em podas, corte de madeira
 e corte de árvores','568.182.718-63',1),
 (2,'Makita','perfeita para desbaste de árvores e arbustos com sabre de 250mm, 
 é uma ferramenta robusta e resistente.','756.993.633-78',2),
 (3,'Tramontina','Uso doméstico. Projetado para fazer acabamentos, contornos e 
 bordas','486.289.926-93',3),
 (4,'Master','Recomendado para cortar grama em pequenas e médias áreas - Manula'
 ,'893.659.579-23',4),
 (5,'Yard Machines - Troy -Bilt','Recomendado para médias e grandes áreas de 
 até 600 m²','795.536.596-83',5),
 (6,'FORTGPRO','limpeza e manutenção de áreas cobertas por relva, grama, ervas
 daninhas e pequenos arbustos. A vantagem da roçadeira é que pode ser usada em 
 locais irregulares, morros, buracos, florestas','861.507.995-14',6),
 (7,'GRH430','Trabalhos intensos e por longos períodos, o equipamento é indicado para o 
 uso em manutenção de vias públicas, controle de pasto e trabalhos de jardinagem.'
 ,'662.147.522-54',7),
 (8,'Master','Trabalhor de curto e medio periodo, indicado para mannnutenção
 de pastos e jardinagem','541.143.106-90',8),
 (9,'Modificado','Kart com motor de motosserra, mais praticidade para suas corridas
 ','808.126.389-64',9),
 (10,'Nagano','Utilizadas em podas, corte de madeira e corte de árvores','655.654.797-20'
 ,10);
 
 insert into reparo_equipamento values(1,2),(2,5),(3,4),(4,1),(5,3),(6,6),
 (7,10),(8,9),(9,8),(10,7);
 
-- 1. selecione os equipamentos que não são do tipo Roçadeira a gasolina
 select *
 from equipamento e
 where  not exists (select *
					from tipo T 
					where T.nome = 'Roçadeira a gasolina' 
                    and ID = e.ID_tipo);
 
 --  2. selecione os reparos que utilizaram a peça 3 e o preço dela
 -- forma 1
 select R.ID as ID_REPARO, P.valor as VALOR_PECA
 from reparo R, peca P
 where R.ID = P.ID_reparo
 and P.ID_p = 3;
-- forma 2
select R.ID as ID_REPARO, P.valor as VALOR_PECA
from reparo R, peca P
where R.ID = P.ID_reparo
and exists (select *
	    from peca PE
        where PE.ID_p = 3
        and PE.ID_p = P.ID_p);
 
 -- 3. selecione a peça mais cara e o reparo para qual foi usada
 select P.ID_p as ID_PECA, P.valor as VALOR, R.ID as ID_REPARO, P.descricao as DESCRICAO_PECA
 from peca P, reparo R
 where P.ID_reparo = R.ID 
 and P.valor>=ALL(select P2.valor
                from peca P2);
 
 --  4. selecione o cliente(s) dono(s) do(s) equipamento(s) da marca FORTGPRO e qual 
 -- peca foi colocada no reparo dessa maquina.
 select *
 from cliente_mecanica C, equipamento E, peca P, reparo_equipamento R
 where E.CPF_cliente = C.CPF_c
 and E.marca = 'FORTGPRO'
 and R.ID_reparo = P.ID_reparo
 and e.ID_equi = R.ID_equipamento;
 
 -- 5. selecione os funcionarios que são atendentes com salario menor que a media salarial dos
 -- mecanicos
 select *
 from funcionario F, funcionario_atendente FA
 where F.CPF = FA.CPF_a
 and F.salario < (select AVG(F1.salario)
                    from funcionario F1, funcionario_mecanico FM
                    where FM.CPF_m = F1.CPF);

-- 6. selecione o 'Técnico de Máquinas' e o reparo que ele fez
-- forma 1
select distinct *
from funcionario_mecanico F, mecanico_tem_especialidade ME, especialidade E, reparo R
where F.CPF_m = ME.CPF_mec
and R.CPF_mecanico = F.CPF_m
and E.nome = 'Técnico de Máquinas'
and E.ID_esp = ME.ID_esp;
-- forma 2
select distinct *
from funcionario_mecanico F, mecanico_tem_especialidade ME, reparo R
where F.CPF_m = ME.CPF_mec
and R.CPF_mecanico = F.CPF_m
and not exists(select *
               from especialidade E
               where E.nome != 'Técnico de Máquinas'
			   and E.ID_esp = ME.ID_esp);

-- 7. separe as peças em grupos cujo o preço seja maior que alguma peça
select *
from peca P
group by P.ID_p
having P.valor >ANY(select P2.valor
                    from peca P2) ;

-- 8. selecione os esquipamentos e os donos, cujo o preço das peças usadas no reparo seja > 100 reais
-- forma 1
select *
from equipamento E, cliente_mecanica C, peca P, reparo_equipamento RE
where E.CPF_cliente = C.CPF_c
and RE.ID_equipamento = E.ID_equi
and P.ID_reparo = RE.ID_reparo
and P.valor > 100;
-- forma 2
select *
from equipamento E, cliente_mecanica C, peca P, reparo_equipamento RE
where E.CPF_cliente = C.CPF_c
and RE.ID_equipamento = E.ID_equi
and P.ID_reparo = RE.ID_reparo
and not exists (select PE.valor
                from peca PE
                where PE.ID_p = P.ID_p
                and PE.valor<=100);

-- 9. selecione os pedidos que foram feitos a pertir do dia '2022-02-03' e a qual equipamento 
-- se refere
-- forma 1
select distinct*
from pedido PE, cliente_mecanica C, equipamento E
where PE.CPF_cliente = C.CPF_c
and PE.dia > '2022-02-03'
and E.CPF_cliente = C.CPF_c;
-- forma 2
select distinct*
from pedido PE, cliente_mecanica C, equipamento E
where PE.CPF_cliente = C.CPF_c
and E.CPF_cliente = C.CPF_c
and not exists(select PEE.dia
			   from pedido PEE
               where PEE.CPF_cliente = PE.CPF_cliente
               and PEE.dia<= '2022-02-03');


-- 10. separe os equipamentos por tipo e conte quantos equipamentos tem em cada tipo
select count(T.ID), T.nome
from equipamento E, tipo T
where E.ID_tipo = T.ID
group by T.ID

