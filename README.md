# 🏥 ClínicaCare Analytics & Machine Learning Pipeline

Projeto integrado de Engenharia de Dados, Modelagem Preditiva e Business Intelligence desenvolvido para otimizar o fluxo operacional, mitigar o risco de inadimplência e fornecer inteligência analítica à gestão da **ClínicaCare**.

---

## 📌 Sumário
- [Visão Geral](#-visão-geral)
- [Arquitetura do Projeto](#-arquitetura-do-projeto)
- [Estrutura do Repositório](#-estrutura-do-repositório)
- [Pipeline de Machine Learning](#-pipeline-de-machine-learning)
- [Painel Power BI](#-painel-power-bi)
- [Principais Insights e Recomendações](#-principais-insights-e-recomendações)
- [Como Executar o Projeto](#-como-executar-o-projeto)

---

## 🎯 Visão Geral
A clínica enfrentava desafios na previsão de fluxo de caixa decorrentes de atrasos e pendências financeiras em consultas médicas particulares e convênios. 

Este projeto entregou uma solução ponta a ponta:
1. **Banco de Dados Relacional (SQL):** Modelagem e estruturação transacional das consultas e pagamentos.
2. **Pipeline de ETL & EDA (Python/Pandas/NumPy):** Extração, engenharia de variáveis e análise exploratória estatística.
3. **Classificação Preditiva (Scikit-Learn):** Algoritmo treinado para categorizar pacientes em três classes de risco (`Baixo`, `Médio`, `Alto`).
4. **Dashboard Executivo (Power BI):** Relatório dinâmico com métricas financeiras, operacionais e predições do modelo.

---

## 🛠️ Arquitetura do Projeto

* **Linguagem & Bibliotecas:** Python (Pandas, NumPy, Matplotlib, Scikit-Learn)
* **Banco de Dados:** SQLite / PostgreSQL (DDL, DML, Consultas Analíticas)
* **Business Intelligence:** Microsoft Power BI Desktop (Visualização & Segmentação de Dados)
* **Ambiente de Desenvolvimento:** VS Code / Jupyter Notebooks

---

## 📁 Estrutura do Repositório

Desafio_Final_WKS_26.2/
├── 1_Modelagem/
│ ├── Modelo_Conceitual_ER.png
│ └── Modelo_Conceitual_ER.brM3
│ └── Modelo_Logico.brM3
│ └── Modelo_Logico.txt
├── 2_SQL/
│ ├── clinica_care.sql
│ └── Analise_Consultas.docx
├── 3_Python/
│ ├── analise_clinica.ipynb
│ └── dados_limpos.csv
├── 4_Power_BI/
│ ├── Dashboard_ClinicaCare.pbix
│ ├── dados.csv (ou .xlsx)
│ └── Insights_Dashboard.docx
└── README.md (resumo do projeto)