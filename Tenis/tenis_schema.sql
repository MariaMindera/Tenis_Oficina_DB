DROP TABLE IF EXISTS encontro_jogadores;
DROP TABLE IF EXISTS encontro_sets;
DROP TABLE IF EXISTS encontro_juizes;
DROP TABLE IF EXISTS encontros;
DROP TABLE IF EXISTS torneios;
DROP TABLE IF EXISTS encontros;
DROP TABLE IF EXISTS arbitros;
DROP TABLE IF EXISTS courts;
DROP TABLE IF EXISTS jogadores;
DROP TABLE IF EXISTS jogos_sets;
DROP TABLE IF EXISTS jogos;
DROP TABLE IF EXISTS `sets`;
DROP TABLE IF EXISTS juizesLinha;


CREATE TABLE torneios(
  torneio_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (torneio_id)
);

CREATE TABLE encontros(
  encontro_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  torneio_id INTEGER UNSIGNED,
  data_inicio DATE,
  data_fim DATE,
  court_id INTEGER UNSIGNED,
  arbitro_id INTEGER UNSIGNED,
  PRIMARY KEY (encontro_id)
);

CREATE TABLE arbitros(
  arbitro_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  idade INTEGER UNSIGNED,
  PRIMARY KEY (arbitro_id)
);

CREATE TABLE encontro_juizes(
  encontro_id INTEGER UNSIGNED,
  juiz_id INTEGER UNSIGNED,
  posicao_juiz ENUM('Juiz de linha lateral', 'Juiz de linha de fundo')
);
ALTER TABLE encontro_juizes ADD CONSTRAINT PK_encontro_juizes PRIMARY KEY (encontro_id, juiz_id);

CREATE TABLE juizesLinha(
  juiz_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  idade INTEGER UNSIGNED,
  PRIMARY KEY (juiz_id)
);

CREATE TABLE encontro_jogadores(
  encontro_id INTEGER UNSIGNED,
  jogador_id INTEGER UNSIGNED,
  jogador ENUM('A', 'B')
);
ALTER TABLE encontro_jogadores ADD CONSTRAINT PK_encontro_jogadores PRIMARY KEY (encontro_id, jogador_id);

CREATE TABLE jogadores(
  jogador_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  idade INTEGER UNSIGNED,
  ranking_ATP INTEGER UNSIGNED,
  PRIMARY KEY (jogador_id)
);

CREATE TABLE courts(
  court_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  max_lotacao INTEGER UNSIGNED,
  PRIMARY KEY (court_id)
);

CREATE TABLE encontro_sets(
  encontro_id INTEGER UNSIGNED,
  set_id INTEGER UNSIGNED
);
ALTER TABLE encontro_sets ADD CONSTRAINT PK_encontro_sets PRIMARY KEY (encontro_id, set_id);

CREATE TABLE sets(
  set_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  duracao TIME,
  resultado_A INTEGER UNSIGNED,
  resultado_B INTEGER UNSIGNED,
  PRIMARY KEY (set_id)
);

CREATE TABLE jogos_sets(
  jogo_id INTEGER UNSIGNED,
  set_id INTEGER UNSIGNED
);
ALTER TABLE jogos_sets ADD CONSTRAINT PK_jogos_sets PRIMARY KEY (jogo_id, set_id);

CREATE TABLE jogos(
  jogo_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  resultado_A INTEGER UNSIGNED,
  resultado_B INTEGER UNSIGNED,
  PRIMARY KEY (jogo_id)
);


ALTER TABLE torneios AUTO_INCREMENT = 1;
ALTER TABLE encontros AUTO_INCREMENT = 1;
ALTER TABLE arbitros AUTO_INCREMENT = 1;
ALTER TABLE juizesLinha AUTO_INCREMENT = 1;
ALTER TABLE jogadores AUTO_INCREMENT = 1;
ALTER TABLE courts AUTO_INCREMENT = 1;
ALTER TABLE sets AUTO_INCREMENT = 1;
ALTER TABLE jogos AUTO_INCREMENT = 1;


ALTER TABLE encontros ADD CONSTRAINT FK_encontro_court_id FOREIGN KEY (court_id) REFERENCES courts(court_id);
ALTER TABLE encontros ADD CONSTRAINT FK_encontro_arbitro_id FOREIGN KEY (arbitro_id) REFERENCES arbitros(arbitro_id);
ALTER TABLE encontros ADD CONSTRAINT FK_encontro_torneio_id FOREIGN KEY (torneio_id) REFERENCES torneios(torneio_id);
ALTER TABLE encontro_juizes ADD CONSTRAINT FK_encontro_juizes_encontro_id FOREIGN KEY (encontro_id) REFERENCES encontros(encontro_id);
ALTER TABLE encontro_juizes ADD CONSTRAINT FK_encontro_juizes_juiz_id FOREIGN KEY (juiz_id) REFERENCES juizesLinha(juiz_id);
ALTER TABLE encontro_jogadores ADD CONSTRAINT FK_encontro_jogadores_encontro_id FOREIGN KEY (encontro_id) REFERENCES encontros(encontro_id);
ALTER TABLE encontro_jogadores ADD CONSTRAINT FK_encontro_jogadores_jogador_id FOREIGN KEY (jogador_id) REFERENCES jogadores(jogador_id);
ALTER TABLE encontro_sets ADD CONSTRAINT FK_encontro_sets_encontro_id FOREIGN KEY (encontro_id) REFERENCES encontros(encontro_id);
ALTER TABLE encontro_sets ADD CONSTRAINT FK_encontro_sets_set_id FOREIGN KEY (set_id) REFERENCES sets(set_id);
ALTER TABLE jogos_sets ADD CONSTRAINT FK_jogos_sets_jogo_id FOREIGN KEY (jogo_id) REFERENCES jogos(jogo_id);
ALTER TABLE jogos_sets ADD CONSTRAINT FK_jogos_sets_set_id FOREIGN KEY (set_id) REFERENCES sets(set_id);