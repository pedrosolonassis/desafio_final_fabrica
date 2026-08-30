CREATE DATABASE IF NOT EXISTS clinica_care;

USE clinica_care;

-- DDL (Parte 1): Criação das tabelas do banco de dados

-- Criar tabela de pacientes
CREATE TABLE IF NOT EXISTS pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    genero VARCHAR(20) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    tipo_plano VARCHAR(40) NOT NULL
);

-- Criar tabela de médicos
CREATE TABLE IF NOT EXISTS medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(11) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    horario_atendimento TIME NOT NULL,
    data_admissao DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Ativo',
    nota_avaliacoes DECIMAL(3, 2) DEFAULT 5.00
);

-- Criar tabela de especialidades
CREATE TABLE IF NOT EXISTS especialidades (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome_especialidade VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    consulta_tempo_min INT NOT NULL,
    valor_medio DECIMAL(10, 2) NOT NULL,
    encaminhamento VARCHAR(10) NOT NULL DEFAULT 'Não',
    qtde_formados INT DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'Ativa'
);

-- Criar tabela de consultas
CREATE TABLE IF NOT EXISTS consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    data_consulta DATE NOT NULL,
    hora_consulta TIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    valor_consulta DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_consultas_pacientes FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    CONSTRAINT fk_consultas_medicos FOREIGN KEY (id_medico) REFERENCES medicos (id_medico),
    CONSTRAINT fk_consultas_especialidades FOREIGN KEY (id_especialidade) REFERENCES especialidades (id_especialidade)
);

-- Criar tabela de pagamentos
CREATE TABLE IF NOT EXISTS pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_consulta INT NOT NULL UNIQUE,
    valor_pago DECIMAL(10, 2) NOT NULL,
    metodo_pagamento VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    data DATETIME NOT NULL,
    recibo VARCHAR(50) UNIQUE,
    convenio VARCHAR(50),
    CONSTRAINT fk_pagamentos_consultas FOREIGN KEY (id_consulta) REFERENCES consultas (id_consulta)
);

-- Criar tabela de prontuário
CREATE TABLE IF NOT EXISTS prontuario (
    id_prontuario INT AUTO_INCREMENT PRIMARY KEY,
    id_consulta INT NOT NULL UNIQUE,
    id_paciente INT NOT NULL,
    data_registro DATETIME NOT NULL,
    pressao VARCHAR(20),
    altura DECIMAL(4, 2),
    peso DECIMAL(5, 2),
    diagnostico VARCHAR(255) NOT NULL,
    anotacoes TEXT,
    CONSTRAINT fk_prontuario_consultas FOREIGN KEY (id_consulta) REFERENCES consultas (id_consulta),
    CONSTRAINT fk_prontuario_pacientes FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente)
);

-- Criar tabela de prescrições
CREATE TABLE IF NOT EXISTS prescricoes (
    id_prescricoes INT AUTO_INCREMENT PRIMARY KEY,
    id_prontuario INT NOT NULL,
    medicamento VARCHAR(100) NOT NULL,
    dosagem VARCHAR(50) NOT NULL,
    frequencia VARCHAR(50) NOT NULL,
    duracao_dias INT NOT NULL,
    tipo_medicamento VARCHAR(50),
    instrucoes VARCHAR(255),
    CONSTRAINT fk_prescricoes_prontuario FOREIGN KEY (id_prontuario) REFERENCES prontuario (id_prontuario)
);

-- DML (Parte 2): Inserção de dados nas tabelas do banco de dados.

-- Inserção de dados na tabela de pacientes
INSERT INTO pacientes (nome_completo, cpf, data_nascimento, genero, telefone, email, tipo_plano) VALUES
('Maria Júlia Maranhão', '11122233344', '1995-03-12', 'Feminino', '83988881111', 'julia.maranhao@gmail.com', 'Unimed'),
('Pedro Solon Assis', '22233344455', '1988-07-25', 'Masculino', '83988882222', 'solon.pedro@gmail.com', 'Particular'),
('Safira Luz Souza', '33344455566', '2001-11-04', 'Feminino', '83988883333', 'safira.luz@gmail.com', 'Bradesco Saúde'),
('Igor Edmundo de Castilho', '44455566677', '1975-01-19', 'Masculino', '83988884444', 'igor.cstilho@gmail.com', 'Hapvida'),
('Maria Antonieta Vieira', '55566677788', '1992-09-30', 'Feminino', '83988885555', 'antonieta.vieira@gmail.com', 'Particular'),
('Miguel Carvalho Oliveira', '66677788899', '1983-05-14', 'Masculino', '83988886666', 'miguel.oliveira@gmail.com', 'Unimed'),
('Maria Glória Leal', '77788899900', '2003-08-22', 'Feminino', '83988887777', 'gloria.leal@gmail.com', 'Amil'),
('Marcos Alves da Silva', '88899900011', '1968-12-05', 'Masculino', '83988888888', 'marcos.alves@email.com', 'Bradesco Saúde'),
('Camilly Maria Egito', '99900011122', '1999-04-18', 'Feminino', '83988889999', 'camilly.maria@gmail.com', 'Particular'),
('Mateus Almeida de Figueiredo', '10120230344', '1990-06-11', 'Masculino', '83987771111', 'mateus.almeida@gmail.com', 'Unimed'),
('Yasmin Lundgren Carvalho', '20230340455', '1986-10-09', 'Feminino', '83987772222', 'yasmin.lundgren@gmail.com', 'Hapvida'),
('Maria Clara Maciel', '30340450566', '1979-02-27', 'Feminino', '83987773333', 'maria.maciel@gmail.com', 'Particular'),
('Maria Clara Medeiros', '40450560677', '1997-12-15', 'Feminino', '83987774444', 'clara.medeiros@gmail.com', 'Amil'),
('Diogo Aguiar Nogueira', '50560670788', '1962-07-08', 'Masculino', '83987775555', 'diogo.aguiar@gmail.com', 'Bradesco Saúde'),
('Mayan Soares Silva', '60670780899', '2000-03-21', 'Feminino', '83987776666', 'mayana.soares@gmail.com', 'Unimed');

-- Inserção de dados na tabela de médicos
INSERT INTO medicos (nome_completo, crm, telefone, email, horario_atendimento, data_admissao, status, nota_avaliacoes) VALUES
('Dr. Roberto Albuquerque', 'CRM-PB 1234', '83981110001', 'roberto.albuquerque@clinicacare.com', '08:00:00', '2015-02-01', 'Ativo', 4,95),
('Dra. Mariana Vasconcelos', 'CRM-PB 2345', '83981110002', 'mariana.v@clinicacare.com', '09:00:00', '2016-06-15', 'Ativo', 4,88),
('Dr. Carlos Eduardo Meireles', 'CRM-PB 3456', '83981110003', 'carlos.meireles@clinicacare.com', '08:30:00', '2018-01-10', 'Ativo', 4,75),
('Dra. Juliana Aguiar Paiva', 'CRM-PB 4567', '83981110004', 'juliana.paiva@clinicacare.com', '10:00:00', '2019-04-20', 'Ativo', 4,92),
('Dr. André Luiz Barreto', 'CRM-PB 5678', '83981110005', 'andre.barreto@clinicacare.com', '13:00:00', '2017-09-01', 'Ativo', 4,80),
('Dra. Beatriz Helena Lins', 'CRM-PB 6789', '83981110006', 'beatriz.lins@clinicacare.com', '14:00:00', '2020-03-12', 'Ativo', 4,65),
('Dr. Gustavo Henrique Neves', 'CRM-PB 7890', '83981110007', 'gustavo.neves@clinicacare.com', '08:00:00', '2021-08-01', 'Ativo', 4,70),
('Dra. Renata Fontes Siqueira', 'CRM-PB 8901', '83981110008', 'renata.siqueira@clinicacare.com', '09:30:00', '2015-11-20', 'Ativo', 4,98),
('Dr. Lucas Medeiros Cunha', 'CRM-PB 9012', '83981110009', 'lucas.cunha@clinicacare.com', '11:00:00', '2022-02-14', 'Ativo', 4,50),
('Dra. Priscila Brandão Maia', 'CRM-PB 1357', '83981110010', 'priscila.maia@clinicacare.com', '14:30:00', '2018-07-05', 'Ativo', 4,85),
('Dr. Thiago Caldas Macedo', 'CRM-PB 2468', '83981110011', 'thiago.macedo@clinicacare.com', '15:00:00', '2023-01-16', 'Ativo', 4,60),
('Dra. Vanessa Aragão Rios', 'CRM-PB 3579', '83981110012', 'vanessa.rios@clinicacare.com', '10:30:00', '2019-10-01', 'Ativo', 4,90),
('Dr. Rodrigo Simões Tavares', 'CRM-PB 4680', '83981110013', 'rodrigo.tavares@clinicacare.com', '16:00:00', '2020-05-18', 'Ativo', 4,78),
('Dra. Letícia Carvalho Dias', 'CRM-PB 5791', '83981110014', 'leticia.dias@clinicacare.com', '07:30:00', '2016-12-01', 'Ativo', 4,91),
('Dr. Fernando Guedes Pinto', 'CRM-PB 6802', '83981110015', 'fernando.pinto@clinicacare.com', '13:30:00', '2024-03-01', 'Ativo', 4,40);

-- Inserção de dados na tabela de especialidades
INSERT INTO especialidades (nome_especialidade, descricao, consulta_tempo_min, valor_medio, encaminhamento, qtde_formados, status) VALUES
('Cardiologia', 'Diagnóstico e tratamento de doenças cardíacas', 40, 300,00, 'Não', 12, 'Ativa'),
('Pediatria', 'Cuidados de saúde para bebês, crianças e adolescentes', 30, 250,00, 'Não', 18, 'Ativa'),
('Dermatologia', 'Tratamento de doenças de pele, cabelos e unhas', 30, 280,00, 'Não', 15, 'Ativa'),
('Ortopedia', 'Tratamento de lesões ósseas e articulares', 35, 290,00, 'Não', 10, 'Ativa'),
('Ginecologia', 'Saúde do sistema reprodutor feminino e prevenção', 40, 300,00, 'Não', 14, 'Ativa'),
('Neurologia', 'Diagnóstico de distúrbios do sistema nervoso', 50, 350,00, 'Sim', 8, 'Ativa'),
('Endocrinologia', 'Tratamento de alterações hormonais e metabólicas', 35, 270,00, 'Não', 9, 'Ativa'),
('Oftalmologia', 'Avaliação da visão e saúde ocular', 25, 240,00, 'Não', 11, 'Ativa'),
('Psiquiatria', 'Diagnóstico e tratamento de transtornos mentais', 50, 320,00, 'Não', 13, 'Ativa'),
('Gastroenterologia', 'Cuidados com o aparelho digestivo', 40, 300,00, 'Não', 7, 'Ativa'),
('Otorrinolaringologia', 'Tratamento de ouvido, nariz e garganta', 30, 260,00, 'Não', 9, 'Ativa'),
('Urologia', 'Saúde do sistema urinário e reprodutor masculino', 35, 310,00, 'Não', 6, 'Ativa'),
('Nutrologia', 'Diagnóstico e prevenção de distúrbios nutricionais', 45, 280,00, 'Não', 5, 'Ativa'),
('Pneumologia', 'Tratamento de doenças respiratórias e pulmonares', 40, 300,00, 'Sim', 6, 'Ativa'),
('Reumatologia', 'Doenças inflamatórias e autoimunes', 45, 330,00, 'Sim', 4, 'Ativa');

-- Inserção de dados na tabela de consultas
INSERT INTO consultas (id_paciente, id_medico, id_especialidade, data_consulta, hora_consulta, status, valor_consulta) VALUES
(1, 1, 1, '2026-05-10', '08:00:00', 'Realizada', 300,00),
(2, 2, 2, '2026-05-11', '09:00:00', 'Realizada', 250,00),
(3, 3, 3, '2026-05-12', '08:30:00', 'Cancelada', 280,00),
(4, 4, 4, '2026-05-13', '10:00:00', 'Faltou', 290,00),
(5, 5, 5, '2026-05-14', '13:00:00', 'Realizada', 300,00),
(6, 6, 6, '2026-05-15', '14:00:00', 'Realizada', 350,00),
(8, 8, 8, '2026-06-02', '09:30:00', 'Realizada', 240,00),
(9, 9, 9, '2026-06-03', '11:00:00', 'Realizada', 320,00),
(10, 10, 10, '2026-06-04', '14:30:00', 'Realizada', 300,00),
(11, 11, 11, '2026-06-05', '15:00:00', 'Agendada', 260,00),
(12, 12, 12, '2026-06-08', '10:30:00', 'Realizada', 310,00),
(13, 13, 13, '2026-06-09', '16:00:00', 'Faltou', 280,00),
(14, 14, 14, '2026-06-10', '07:30:00', 'Realizada', 300,00),
(15, 15, 15, '2026-06-11', '13:30:00', 'Realizada', 330,00);

-- Inserção de dados na tabela de pagamentos 
INSERT INTO pagamentos (id_consulta, valor_pago, metodo_pagamento, status, data, recibo, convenio) VALUES
(1, 300,00, 'Cartao', 'Pago', '2026-05-10 08:45:00', 'REC-001', 'Unimed'),
(2, 250,00, 'Pix', 'Pago', '2026-05-11 09:35:00', 'REC-002', 'Particular'),
(3, 0,00, 'Nenhum', 'Cancelado', '2026-05-12 08:30:00', 'REC-003', 'Bradesco Saúde'),
(4, 0,00, 'Nenhum', 'Pendente', '2026-05-13 10:00:00', 'REC-004', 'Hapvida'),
(5, 300,00, 'Dinheiro', 'Pago', '2026-05-14 13:40:00', 'REC-005', 'Particular'),
(6, 350,00, 'Cartao', 'Pago', '2026-05-15 14:50:00', 'REC-006', 'Unimed'),
(7, 0,00, 'Nenhum', 'Pendente', '2026-06-01 08:00:00', 'REC-007', 'Amil'),
(8, 240,00, 'Pix', 'Pago', '2026-06-02 10:00:00', 'REC-008', 'Bradesco Saúde'),
(9, 320,00, 'Cartao', 'Pago', '2026-06-03 11:55:00', 'REC-009', 'Particular'),
(10, 300,00, 'Pix', 'Pago', '2026-06-04 15:10:00', 'REC-010', 'Unimed'),
(11, 260,00, 'Cartao', 'Pendente', '2026-06-05 15:00:00', 'REC-011', 'Hapvida'),
(12, 310,00, 'Dinheiro', 'Pago', '2026-06-08 11:15:00', 'REC-012', 'Particular'),
(13, 0,00, 'Nenhum', 'Pendente', '2026-06-09 16:00:00', 'REC-013', 'Amil'),
(14, 300,00, 'Cartao', 'Pago', '2026-06-10 08:15:00', 'REC-014', 'Bradesco Saúde'),
(15, 330,00, 'Pix', 'Pago', '2026-06-11 14:20:00', 'REC-015', 'Unimed');

-- Inserção de dados na tabela de prontuário
INSERT INTO prontuario (id_consulta, id_paciente, data_registro, pressao, altura, peso, diagnostico, anotacoes) VALUES
(1, 1, '2026-05-10 08:40:00', '12/8', 1,65, 62,00, 'Hipertensão Leve', 'Paciente relata estresse frequente. Solicitado ECG.'),
(2, 2, '2026-05-11 09:30:00', '11/7', 1,20, 24,50, 'Gripe Sazonal', 'Criança com febre e coriza há 2 dias. Hidratação reforçada.'),
(3, 3, '2026-05-12 08:30:00', '12/8', 1,68, 58,00, 'Não Avaliado', 'Consulta cancelada previamente.'),
(4, 4, '2026-05-13 10:00:00', '12/8', 1,75, 82,00, 'Não Avaliado', 'Paciente faltou à consulta.'),
(5, 5, '2026-05-14 13:35:00', '12/7', 1,60, 55,00, 'Check-up Ginecológico', 'Exames preventivos de rotina sem alterações aparentes.'),
(6, 6, '2026-05-15 14:45:00', '13/8', 1,80, 88,00, 'Enxaqueca Crônica', 'Crises intensas no período da tarde. Recomendado diário de dor.'),
(7, 7, '2026-06-01 08:00:00', '12/8', 1,70, 70,00, 'Não Avaliado', 'Paciente faltou à consulta.'),
(8, 8, '2026-06-02 09:55:00', '12/8', 1,72, 76,00, 'Miopia e Astigmatismo', 'Prescrição de lentes corretivas atualizada.'),
(9, 9, '2026-06-03 11:50:00', '12/8', 1,64, 60,00, 'Transtorno de Ansiedade', 'Início de acompanhamento psicoterapêutico associado.'),
(10, 10, '2026-06-04 15:05:00', '13/9', 1,78, 84,00, 'Gastrite Nervosa', 'Apresenta queimação epigástrica. Indicada dieta branda.'),
(11, 11, '2026-06-05 15:00:00', '12/8', 1,62, 59,00, 'Em Aguardo', 'Atendimento agendado.'),
(12, 12, '2026-06-08 11:10:00', '12/8', 1,76, 80,00, 'Cálculo Renal', 'Sintomas de cólica renal moderada. USG solicitada.'),
(13, 13, '2026-06-09 16:00:00', '12/8', 1,67, 68,00, 'Não Avaliado', 'Paciente faltou à consulta.'),
(14, 14, '2026-06-10 08:10:00', '14/9', 1,71, 79,00, 'Asma Leve', 'Episódios esporádicos de falta de ar no inverno.'),
(15, 15, '2026-06-11 14:15:00', '12/8', 1,58, 54,00, 'Artrite Inicial', 'Dores matinais nas articulações das mãos.');

-- Inserção de dados na tabela de prescrições
INSERT INTO prescricoes (id_prontuario, medicamento, dosagem, frequencia, duracao_dias, tipo_medicamento, instrucoes) VALUES
(1, 'Losartana Potássica', '50mg', '1 vez ao dia', 30, 'Anti-hipertensivo', 'Tomar pela manhã em jejum'),
(2, 'Dipirona Gotas', '500mg/ml', '6 em 6 horas', 3, 'Analgésico', 'Tomar se houver dor ou febre > 37.8C'),
(3, 'Nenhum', '0mg', 'N/A', 0, 'Nenhum', 'Consulta cancelada'),
(4, 'Nenhum', '0mg', 'N/A', 0, 'Nenhum', 'Paciente não compareceu'),
(5, 'Ácido Fólico', '5mg', '1 vez ao dia', 60, 'Vitamina', 'Tomar junto ao almoço'),
(6, 'Topiramato', '25mg', '12 em 12 horas', 60, 'Neurológico', 'Aumentar dose conforme orientação médica'),
(7, 'Nenhum', '0mg', 'N/A', 0, 'Nenhum', 'Paciente não compareceu'),
(8, 'Colírio Lubrificante', '1 gota', '8 em 8 horas', 15, 'Oftalmológico', 'Pingar nos dois olhos'),
(9, 'Escitalopram', '10mg', '1 vez ao dia', 30, 'Ansiolítico', 'Tomar pela manhã'),
(10, 'Omeprazol', '20mg', '1 vez ao dia', 28, 'Protetor Gástrico', 'Tomar 30 min antes do café da manhã'),
(11, 'Em Avaliação', '0mg', 'N/A', 0, 'Pendente', 'Aguardando atendimento'),
(12, 'Tansulosina', '0.4mg', '1 vez ao dia', 14, 'Urológico', 'Tomar após o jantar'),
(13, 'Nenhum', '0mg', 'N/A', 0, 'Nenhum', 'Paciente não compareceu'),
(14, 'Salbutamol Spray', '100mcg', 'Se necessário', 30, 'Broncodilatador', 'Inalar 2 puffs em caso de crise'),
(15, 'Metotrexato', '2.5mg', 'Semanal', 90, 'Imunossupressor', 'Tomar exatamente no mesmo dia da semana');

-- Update 1: Atualizar o status da consulta agendada 11 para "Realizada" e ajustar seu valor com desconto
UPDATE consultas 
SET status = 'Realizada', valor_consulta = 230,00 
WHERE id_consulta = 11;

-- Update 2: Baixar o pagamento referente à consulta 11 de "Pendente" para "Pago" com Pix
UPDATE pagamentos 
SET status = 'Pago', valor_pago = 230,00, metodo_pagamento = 'Pix' 
WHERE id_consulta = 11;

-- Update 3: Atualizar o diagnóstico e notas no prontuário da consulta 11 que foi finalizada
UPDATE prontuario 
SET diagnostico = 'Rinite Alérgica', anotacoes = 'Paciente apresentou sintomas leves de espirros e coriza matinal.' 
WHERE id_consulta = 11;

-- DQL (Parte 3): Consultas SQL para análise de dados do banco de dados.

-- Consulta 1: Quantidade total de pacientes cadastrados por tipo de plano (COUNT)
-- Objetivo: Identificar a representatividade dos convênios em relação aos pacientes particulares.
SELECT 
    tipo_plano,
    COUNT(id_paciente) AS total_pacientes
FROM pacientes
GROUP BY tipo_plano
ORDER BY total_pacientes DESC;

-- Consulta 2: Faturamento total e média de valor pago por método de pagamento (SUM e AVG)
-- Objetivo: Compreender o volume financeiro movimentado por cada meio de pagamento na clínica.
SELECT 
    metodo_pagamento,
    COUNT(id_pagamento) AS total_transacoes,
    SUM(valor_pago) AS faturamento_total,
    ROUND(AVG(valor_pago), 2) AS ticket_medio
FROM pagamentos
WHERE status = 'Pago'
GROUP BY metodo_pagamento
ORDER BY faturamento_total DESC;

-- Consulta 3: Faturamento bruto gerado por cada médico com base nas consultas realizadas (SUM e COUNT)
-- Objetivo: Avaliar a produtividade financeira individual dos médicos do corpo clínico.
SELECT 
    t2.nome_completo AS nome_medico,
    COUNT(t1.id_consulta) AS total_consultas_realizadas,
    SUM(t1.valor_consulta) AS faturamento_gerado
FROM consultas t1
INNER JOIN medicos t2 ON t1.id_medico = t2.id_medico
WHERE t1.status = 'Realizada'
GROUP BY t2.nome_completo
ORDER BY faturamento_gerado DESC;

-- Consulta 4: Média, valor mínimo e valor máximo cobrado por especialidade médica (AVG, MIN, MAX)
-- Objetivo: Analisar a dispersão de preços praticados entre as especialidades da clínica.
SELECT 
    t2.nome_especialidade,
    COUNT(t1.id_consulta) AS total_agendamentos,
    MIN(t1.valor_consulta) AS menor_valor,
    MAX(t1.valor_consulta) AS maior_valor,
    ROUND(AVG(t1.valor_consulta), 2) AS media_valor
FROM consultas t1
INNER JOIN especialidades t2 ON t1.id_especialidade = t2.id_especialidade
GROUP BY t2.nome_especialidade
ORDER BY media_valor DESC;

-- Consulta 5: Relatório completo de atendimentos agendados/realizados
-- Objetivo: Listar cada consulta trazendo o nome do paciente, nome do médico e o nome da especialidade.
SELECT 
    t1.id_consulta,
    t1.data_consulta,
    t1.hora_consulta,
    t2.nome_completo AS paciente,
    t2.tipo_plano,
    t3.nome_completo AS medico,
    t3.crm,
    t4.nome_especialidade AS especialidade,
    t1.status AS status_consulta
FROM consultas t1
INNER JOIN pacientes t2 ON t1.id_paciente = t2.id_paciente
INNER JOIN medicos t3 ON t1.id_medico = t3.id_medico
INNER JOIN especialidades t4 ON t1.id_especialidade = t4.id_especialidade
ORDER BY t1.data_consulta ASC, t1.hora_consulta ASC;

-- Consulta 6: Prescrições emitidas vinculadas ao paciente e ao diagnóstico
-- Objetivo: Rastrear quais medicamentos foram receitados para cada paciente e o diagnóstico associado.
SELECT 
    t3.nome_completo AS paciente,
    t2.diagnostico,
    t2.data_registro,
    t1.medicamento,
    t1.dosagem,
    t1.frequencia,
    t1.duracao_dias
FROM prescricoes t1
INNER JOIN prontuario t2 ON t1.id_prontuario = t2.id_prontuario
INNER JOIN pacientes t3 ON t2.id_paciente = t3.id_paciente
WHERE t1.medicamento <> 'Nenhum'
ORDER BY t2.data_registro DESC;

-- Consulta 7: Pacientes e seus respectivos históricos de pagamentos
-- Objetivo: Cruzar pacientes com consultas e pagamentos para identificar pendências financeiras.
SELECT 
    t1.id_paciente,
    t1.nome_completo AS paciente,
    t2.id_consulta,
    t2.status AS status_consulta,
    t3.valor_pago,
    t3.metodo_pagamento,
    t3.status AS status_pagamento
FROM pacientes t1
LEFT JOIN consultas t2 ON t2.id_paciente = t1.id_paciente
LEFT JOIN pagamentos t3 ON t2.id_consulta = t3.id_consulta
ORDER BY t2.id_paciente ASC;

-- Consulta 8: Médicos e prontuários preenchidos
-- Objetivo: Verificar o volume de prontuários médicos gerados por profissional, incluindo os que não geraram prontuário.
SELECT 
    t1.id_medico,
    t1.nome_completo AS medico,
    t3.nome_especialidade,
    COUNT(t4.id_prontuario) AS total_prontuarios_gerados
FROM medicos t1
INNER JOIN consultas t2 ON t1.id_medico = t2.id_medico
INNER JOIN especialidades t3 ON t2.id_especialidade = t3.id_especialidade
LEFT JOIN prontuario t4 ON t2.id_consulta = t4.id_consulta AND t4.diagnostico <> 'Não Avaliado'
GROUP BY t1.id_medico, t1.nome_completo, t3.nome_especialidade
ORDER BY total_prontuarios_gerados DESC;