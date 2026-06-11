---
layout: project
title: "beAnalytic: Lakehouse de Acidentes de Trânsito"
date: 2024-06-21
summary: "Pipeline Medallion (raw → bronze → silver) com Airflow, PySpark e Delta Lake sobre dados abertos de acidentes de trânsito de BH, entregando um modelo dimensional (star schema)."
repo: "https://github.com/lucas-placido/beAnalytic"
thumbnail: /assets/images/beanalytic.svg
tags: ["Airflow","PySpark","Delta Lake","Medallion","Modelagem Dimensional"]
---

## Objetivo
Pipeline de dados de ponta a ponta sobre um dataset público real — da ingestão automatizada à camada analítica dimensional — usando os **boletins de acidentes de trânsito com vítimas de Belo Horizonte** (dados abertos da Prefeitura, portal CKAN, 2011–2022).

## Arquitetura (Medallion)
```
CKAN API (PBH) → Airflow DAG (ckan_extractor, @daily)
        ▼
raw (CSV bruto)
        │  PySpark
        ▼
bronze (Delta — tipagem, rename, metadata de ingestão/linhagem)
        │  PySpark
        ▼
silver (Delta — star schema)
   fact_ocorrencias + dim_acidentes · dim_tempos · dim_pavimentos
   · dim_regional · dim_ups · dim_boletim
```

## Destaques técnicos
- **Orquestração com Airflow** (Astronomer/Astro Runtime): DAG diária que extrai os recursos da API CKAN.
- **Arquitetura Medallion** com **Delta Lake** (ACID, versionamento, time travel).
- **Modelagem dimensional** (star schema) com **surrogate keys** (`sk_boletim`).
- **Carga idempotente** via `MERGE` do Delta (upsert por chave de negócio `numero_boletim`).
- Tratamento de dado real: encoding `ISO-8859-1`, schema explícito e metadados de linhagem.

## Stack
`Apache Airflow` · `PySpark` · `Delta Lake` · `Docker` · `Python` · `CKAN Open Data`
