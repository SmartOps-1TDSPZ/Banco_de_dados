-- Tabela CLIENTE
CREATE TABLE T_CLIENTE (
    id_clientes      INTEGER CONSTRAINT id_clientes PRIMARY KEY,
    nm_cliente       VARCHAR2(255) NOT NULL,
    nr_cpf           VARCHAR2(14) NOT NULL CONSTRAINT nr_cpf UNIQUE, --Coloquei cpf como varchar pois agora pode haver caracteres no cpf
    nr_rg            VARCHAR2(10),
    dt_nascimento    DATE,
    nr_telefone      INTEGER,
    sexo             CHAR(1) CHECK (sexo IN('M','F'))
);

-- Tabela ENDERECO
CREATE TABLE T_ENDERECO (
    id_endereco      INTEGER CONSTRAINT id_endereco PRIMARY KEY,
    nm_logradouro    VARCHAR2(120) NOT NULL,
    nm_bairro        VARCHAR2(120) NOT NULL,
    nm_cidade        VARCHAR2(120) NOT NULL,
    nm_estado        VARCHAR2(4) NOT NULL,
    nr_cep           VARCHAR2(12) NOT NULL,
    pt_referencia    VARCHAR2(255),
    id_clientes      INTEGER NOT NULL,
    CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_clientes) REFERENCES T_CLIENTE(id_clientes)
);

-- Tabela ACESSO
CREATE TABLE T_ACESSO (
    id_acesso        INTEGER CONSTRAINT id_acesso PRIMARY KEY,
    email            VARCHAR2(100) NOT NULL CONSTRAINT email UNIQUE,
    senha            VARCHAR2(100) NOT NULL,
    sit_acesso       BOOLEAN,
    dt_cadastro      DATE,
    id_clientes      INTEGER NOT NULL,
    CONSTRAINT fk_acesso_cliente FOREIGN KEY (id_clientes) REFERENCES T_CLIENTE(id_clientes)
);

-- Tabela CARRO
CREATE TABLE T_CARRO (
    id_carro         INTEGER CONSTRAINT id_carro PRIMARY KEY,
    nr_chassi        VARCHAR2(20) NOT NULL CONSTRAINT nr_chassi UNIQUE,
    cilindrada       VARCHAR2(10) NOT NULL,
    nm_marca         VARCHAR2(20) NOT NULL,
    nm_modelo        VARCHAR2(40) NOT NULL,
    nr_placa         VARCHAR2(20) NOT NULL CONSTRAINT unq_placa UNIQUE,
    ano_fabricacao   DATE,
    tp_veiculo       VARCHAR2(30) NOT NULL,
    id_clientes      INTEGER NOT NULL,
    CONSTRAINT fk_carro_cliente FOREIGN KEY (id_clientes) REFERENCES T_CLIENTE(id_clientes)
);

-- Tabela MOTOR
CREATE TABLE T_MOTOR (
    id_motor         INTEGER CONSTRAINT id_motor PRIMARY KEY,
    qtd_combustivel  VARCHAR2(255),
    cilindrada       VARCHAR2(10) NOT NULL,
    nr_potencia      VARCHAR2(800),
    id_carro         INTEGER NOT NULL,
    CONSTRAINT fk_motor_carro FOREIGN KEY (id_carro) REFERENCES T_CARRO(id_carro)
);

-- Tabela ORCAMENTO
CREATE TABLE T_ORCAMENTO (
    id_orcamento     INTEGER CONSTRAINT pk_orcamento PRIMARY KEY,
    vl_total         NUMERIC NOT NULL CHECK (vl_total > 0),
    ct_pecas         NUMERIC(2,4) CHECK (ct_pecas >= 0),
    tx_servico       NUMERIC(2,4) CHECK (tx_servico >= 0),
    dt_orcamento     DATE,
    id_carro         INTEGER NOT NULL,
    CONSTRAINT fk_orcamento_carro FOREIGN KEY (id_carro) REFERENCES T_CARRO(id_carro)
);

-- Tabela PROBLEMA_CARRO
CREATE TABLE T_PROBLEMA_CARRO (
    id_problema_carro INTEGER CONSTRAINT id_problema_carro PRIMARY KEY,
    gravidade         VARCHAR2(1000) NOT NULL,
    dt_deteccao       DATE NOT NULL,
    tp_problema       VARCHAR2(255) NOT NULL,
    id_carro          INTEGER NOT NULL,
    CONSTRAINT fk_problema_carro FOREIGN KEY (id_carro) REFERENCES T_CARRO(id_carro)
);

-- Tabela SOLUCAO
CREATE TABLE T_SOLUCAO (
    id_solucao        INTEGER CONSTRAINT pk_solucao PRIMARY KEY,
    des_solucao       VARCHAR2(255) N   OT NULL,
    nr_pecas_usadas   VARCHAR2(150),
    temp_reparo       DATE NOT NULL,
    id_problema_carro INTEGER NOT NULL,
    CONSTRAINT fk_solucao_problema_carro FOREIGN KEY (id_problema_carro) REFERENCES T_PROBLEMA_CARRO(id_problema_carro)
);