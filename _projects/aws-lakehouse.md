---
layout: project
title: "AWS Lakehouse com Apache Iceberg"
date: 2025-11-15
summary: "Lakehouse serverless na AWS com Apache Iceberg e arquitetura Medallion (Bronze/Silver/Gold), orquestrado por Step Functions e provisionado 100% com Terraform."
repo: "https://github.com/lucas-placido/aws-lakehouse"
thumbnail: /assets/images/aws-lakehouse.svg
tags: ["AWS","Apache Iceberg","Glue","Step Functions","Terraform"]
---

## Objetivo
Demonstrar uma arquitetura moderna de lakehouse na AWS de ponta a ponta — da ingestão à camada analítica — usando **Apache Iceberg** (ACID, time travel, schema evolution) e a arquitetura **Medallion**, com tudo provisionado como código.

## Arquitetura
```
NYC TLC (AWS Open Data) → Lambda (ingestão, EventBridge diário)
        ▼
S3 Bronze (raw, imutável, particionado)
        │  Glue Job
        ▼
S3 Silver (Iceberg — limpeza, dedup, qualidade)
        │  Glue Job
        ▼
S3 Gold (Iceberg — star schema: fatos & dimensões)
        ▼
Athena / QuickSight (consulta e BI)
```
Orquestração do pipeline (`IngestBronze → BronzeToSilver → SilverToGold → Maintenance`) via **Step Functions**, agendada por **EventBridge**.

## Destaques técnicos
- **Apache Iceberg** nas camadas Silver e Gold: transações ACID, time travel e particionamento otimizado.
- **Qualidade de dados** na Silver: validação (duração, distância, valor) e deduplicação por window function.
- **Modelagem dimensional** na Gold: `fact_trips` + `dim_vendor` + `dim_taxi_zone`.
- **Serverless e idempotente:** Lambda + Step Functions, ingestão que evita reprocessar arquivos já carregados.
- **Manutenção automática do Iceberg** (semanal): expire snapshots, compaction e remoção de arquivos órfãos.
- **Infra como código:** Terraform provisiona S3, Glue (databases/jobs), Lambda, Step Functions, EventBridge e IAM com least privilege.

## Resultados
- Pipeline Medallion completo, agendado e reproduzível, com camadas Bronze/Silver/Gold padronizadas.
- Tabelas Gold prontas para BI, consultáveis em SQL via Athena.
- Custo controlado (tier on-demand) com otimizações de storage e particionamento.

## Stack
`AWS` · `Apache Iceberg` · `S3` · `Glue` · `Lambda` · `Step Functions` · `EventBridge` · `Athena` · `Terraform`
