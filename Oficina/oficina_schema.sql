DROP TABLE IF EXISTS funcionarios_horasTrabalho;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS especialidades;
DROP TABLE IF EXISTS pecasUtilizadas;
DROP TABLE IF EXISTS reparacoes;
DROP TABLE IF EXISTS proprietarios;
DROP TABLE IF EXISTS carros;
DROP TABLE IF EXISTS peca_modelo;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS pecas;
DROP TABLE IF EXISTS modelos;
DROP TABLE IF EXISTS marcas;


CREATE TABLE reparacoes(
  reparacao_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  cliente_id INTEGER UNSIGNED,
  carro_id INTEGER UNSIGNED,
  data_inicio DATE,
  data_fim DATE,
  PRIMARY KEY (reparacao_id)
);

CREATE TABLE funcionarios_horasTrabalho(
  reparacao_id INTEGER UNSIGNED,
  funcionario_id INTEGER UNSIGNED,
  horas INTEGER UNSIGNED
);
ALTER TABLE funcionarios_horasTrabalho ADD CONSTRAINT PK_funcionarios_horasTrabalho PRIMARY KEY (reparacao_id, funcionario_id);

CREATE TABLE funcionarios(
  funcionario_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  morada VARCHAR(100),
  telemovel INTEGER UNSIGNED,
  especialidade_id INTEGER UNSIGNED,
  PRIMARY KEY (funcionario_id)
);

CREATE TABLE especialidades(
  especialidade_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  custoHora INTEGER UNSIGNED,
  PRIMARY KEY (especialidade_id)
);

CREATE TABLE carros(
  carro_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  matricula VARCHAR(30),
  modelo_id INTEGER UNSIGNED,
  PRIMARY KEY (carro_id)
);

CREATE TABLE proprietarios(
  carro_id INTEGER UNSIGNED,
  cliente_id INTEGER UNSIGNED,
  proprietario INTEGER UNSIGNED
);
ALTER TABLE proprietarios ADD CONSTRAINT PK_proprietario PRIMARY KEY (carro_id, cliente_id);

CREATE TABLE clientes(
  cliente_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  morada VARCHAR(100),
  telemovel INTEGER UNSIGNED,
  PRIMARY KEY (cliente_id)
);

CREATE TABLE pecasUtilizadas(
  reparacao_id INTEGER UNSIGNED,
  peca_id INTEGER UNSIGNED,
  quantidade INTEGER UNSIGNED
);
ALTER TABLE pecasUtilizadas ADD CONSTRAINT PK_pecasUtilizadas PRIMARY KEY (reparacao_id, peca_id);

CREATE TABLE modelos(
  modelo_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  marca_id INTEGER UNSIGNED,
  PRIMARY KEY (modelo_id)
);

CREATE TABLE pecas(
  peca_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  designacao VARCHAR(70),
  codigo INTEGER UNSIGNED,
  custo INTEGER UNSIGNED,
  stock INTEGER UNSIGNED,
  PRIMARY KEY (peca_id)
);

CREATE TABLE peca_modelo(
  modelo_id INTEGER UNSIGNED,
  peca_id INTEGER UNSIGNED
);
ALTER TABLE peca_modelo ADD CONSTRAINT PK_peca_modelo PRIMARY KEY (modelo_id, peca_id);

CREATE TABLE marcas(
  marca_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  PRIMARY KEY (marca_id)
);


ALTER TABLE reparacoes AUTO_INCREMENT = 1;
ALTER TABLE funcionarios AUTO_INCREMENT = 1;
ALTER TABLE especialidades AUTO_INCREMENT = 1;
ALTER TABLE carros AUTO_INCREMENT = 1;
ALTER TABLE clientes AUTO_INCREMENT = 1;
ALTER TABLE modelos AUTO_INCREMENT = 1;
ALTER TABLE pecas AUTO_INCREMENT = 1;
ALTER TABLE marcas AUTO_INCREMENT = 1;


ALTER TABLE funcionarios_horasTrabalho ADD CONSTRAINT FK_funcionarios_horasTrabalho_reparacao_id FOREIGN KEY (reparacao_id) REFERENCES reparacoes(reparacao_id);
ALTER TABLE funcionarios_horasTrabalho ADD CONSTRAINT FK_funcionarios_horasTrabalho_funcionario_id FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id);
ALTER TABLE funcionarios ADD CONSTRAINT FK_funcionarios_especialidade_id FOREIGN KEY (especialidade_id) REFERENCES especialidades(especialidade_id);
ALTER TABLE reparacoes ADD CONSTRAINT FK_reparacoes_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id);
ALTER TABLE reparacoes ADD CONSTRAINT FK_reparacoes_carro_id FOREIGN KEY (carro_id) REFERENCES carros(carro_id);
ALTER TABLE pecasUtilizadas ADD CONSTRAINT FK_pecasUtilizadas_reparacao_id FOREIGN KEY (reparacao_id) REFERENCES reparacoes(reparacao_id);
ALTER TABLE pecasUtilizadas ADD CONSTRAINT FK_pecasUtilizadas_peca_id FOREIGN KEY (peca_id) REFERENCES pecas(peca_id);
ALTER TABLE carros ADD CONSTRAINT FK_carros_modelo_id FOREIGN KEY (modelo_id) REFERENCES modelos(modelo_id);
ALTER TABLE proprietarios ADD CONSTRAINT FK_proprietarios_carro_id FOREIGN KEY (carro_id) REFERENCES carros(carro_id);
ALTER TABLE proprietarios ADD CONSTRAINT FK_proprietarios_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id);
ALTER TABLE proprietarios ADD CONSTRAINT FK_proprietarios_proprietario FOREIGN KEY (proprietario) REFERENCES clientes(cliente_id);
ALTER TABLE modelos ADD CONSTRAINT FK_modelos_marca_id FOREIGN KEY (marca_id) REFERENCES marcas(marca_id);
ALTER TABLE peca_modelo ADD CONSTRAINT FK_peca_modelo_modelo_id FOREIGN KEY (modelo_id) REFERENCES modelos(modelo_id);
ALTER TABLE peca_modelo ADD CONSTRAINT FK_peca_modelo_peca_id FOREIGN KEY (peca_id) REFERENCES pecas(peca_id);