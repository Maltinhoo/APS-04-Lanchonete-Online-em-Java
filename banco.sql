CREATE DATABASE lanchonete
ENCODING UTF8
TEMPLATE template0

------------------------------------

CREATE TABLE tb_funcionarios(
	id_funcionario	SERIAL,
	nome			VARCHAR(30) CONSTRAINT nn_tb_func_nome NOT NULL,
	sobrenome		VARCHAR(30) CONSTRAINT nn_tb_func_sobrenome NOT NULL,
	usuario			VARCHAR(20) CONSTRAINT nn_tb_func_usuario NOT NULL,
	senha			TEXT CONSTRAINT nn_tb_func_usuario NOT NULL,
	salario			NUMERIC(7,2) CONSTRAINT nn_tb_func_salario NOT NULL,
	cad_por			INTEGER CONSTRAINT nn_tb_func_cad_por NOT NULL,
	fg_ativo		INTEGER CONSTRAINT nn_tb_func_fg_ativo NOT NULL,
	CONSTRAINT pk_tb_func_id_func PRIMARY KEY(id_funcionario),
	CONSTRAINT fk_tb_func_id_func FOREIGN KEY(cad_por) REFERENCES tb_funcionarios(id_funcionario)
);

CREATE TABLE tb_enderecos(
	id_endereco		SERIAL,
	rua				VARCHAR(80) CONSTRAINT nn_tb_enderecos_rua NOT NULL,
	bairro			VARCHAR(50) CONSTRAINT nn_tb_enderecos_bairro NOT NULL,
	numero			INTEGER,
	complemento		VARCHAR(30),
	cidade			VARCHAR(50) CONSTRAINT nn_tb_enderecos_cidade NOT NULL,
	estado			CHAR(2) CONSTRAINT nn_tb_enderecos_estado NOT NULL,
	CONSTRAINT pk_tb_enderecos_id_endereco PRIMARY KEY(id_endereco)
);

CREATE TABLE tb_clientes(
	id_cliente		SERIAL,
	nome			VARCHAR(30) CONSTRAINT nn_tb_clientes_nome NOT NULL,
	sobrenome		VARCHAR(30) CONSTRAINT nn_tb_clientes_sobrenome NOT NULL,
	telefone		VARCHAR(20) CONSTRAINT nn_tb_clientes_teledone NOT NULL,
	usuario			VARCHAR(30) CONSTRAINT nn_tb_clientes_usuario NOT NULL,
	senha			TEXT CONSTRAINT nn_tb_clientes_senha NOT NULL,
	fg_ativo		INTEGER CONSTRAINT nn_tb_clientes_fg_ativo NOT NULL,
	id_endereco		INTEGER,
	CONSTRAINT pk_tb_clientes_id_cliente PRIMARY KEY(id_cliente),
	CONSTRAINT fk_tb_clientes_id_endereco FOREIGN KEY(id_endereco) REFERENCES tb_enderecos(id_endereco)
);

CREATE TABLE tb_ingredientes(
	id_ingrediente	SERIAL,
	nm_ingrediente	VARCHAR(40) CONSTRAINT nn_tb_ingrd_nm_ingrd NOT NULL,
	descricao		TEXT CONSTRAINT nn_tb_ingrd_descricao NOT NULL,
	quantidade		INTEGER CONSTRAINT nn_tb_ingrd_qntd NOT NULL,
	valor_compra	NUMERIC(7,2) CONSTRAINT nn_tb_ingrd_valor_compra NOT NULL,
	valor_venda		NUMERIC(7,2) CONSTRAINT nn_tb_ingrd_valor_venda NOT NULL,
	fg_ativo		INTEGER CONSTRAINT nn_tb_ingrd_fg_ativo NOT NULL,
	CONSTRAINT pk_tb_ingrd_id_igrd PRIMARY KEY(id_ingrediente)
);

CREATE TABLE tb_lanches(
	id_lanche		SERIAL,
	nm_lanche		VARCHAR(30) CONSTRAINT nn_tb_lanches_nm_lanche NOT NULL,
	descricao		TEXT CONSTRAINT nn_tb_lanches_nm_lanche NOT NULL,
	valor_venda		NUMERIC(7,2),
	fg_ativo		INTEGER CONSTRAINT nn_tb_lanches_fg_ativo NOT NULL,
	valor_lanche	NUMERIC(7,2) CONSTRAINT nn_tb_lanches_valor_lanche NOT NULL,
	CONSTRAINT pk_tb_lanches_id_lanche PRIMARY KEY(id_lanche)
);

CREATE TABLE tb_ingredientes_lanche(
	id_lanche		INTEGER,
	id_ingrediente	INTEGER,
	quantidade		INTEGER CONSTRAINT nn_tb_ingrd_lanche NOT NULL,
	CONSTRAINT pk_tb_ingrd_lanche_id_igrd_id_lanche PRIMARY KEY(id_ingrediente, id_lanche),
	CONSTRAINT fk_tb_ingrd_lanche_id_lanche FOREIGN KEY(id_lanche) REFERENCES tb_lanches(id_lanche),
	CONSTRAINT fk_tb_ingrd_lanche_id_ingrediente FOREIGN KEY(id_ingrediente) REFERENCES tb_ingredientes(id_ingrediente)
);

CREATE TABLE tb_pedidos(
	id_pedido		SERIAL,
	id_lanche		INTEGER CONSTRAINT nn_tb_pedidos_id_lanche NOT NULL,
	id_cliente		INTEGER CONSTRAINT nn_tb_pedidos_id_cliente NOT NULL,
	data_pedido		VARCHAR(20) CONSTRAINT nn_tb_pedidos_data_pedido NOT NULL,
	valor_total		NUMERIC(7,2) CONSTRAINT nn_tb_pedidos_valor_total NOT NULL,
	CONSTRAINT pk_tb_pedidos_id_pedido PRIMARY KEY(id_pedido),
	CONSTRAINT fk_tb_pedidos_id_lanche FOREIGN KEY(id_lanche) REFERENCES tb_lanches(id_lanche),
	CONSTRAINT fk_tb_pedidos_id_cliente FOREIGN KEY(id_cliente) REFERENCES tb_clientes(id_cliente)
);