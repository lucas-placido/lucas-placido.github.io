---
layout: project
title: "Lakehouse para BI: Bronze/Silver/Gold"
date: 2025-11-01
summary: "Arquitetura Delta Lake integrada ao Power BI, reduzindo latência dos dashboards em ~60%."
tags: ["Databricks","Delta Lake","Power BI","S3","ETL"]
thumbnail: /assets/images/lakehouse-thumb.png
---

## Objetivo
Reduzir o tempo de atualização dos dashboards e padronizar camadas de dados.

## Arquitetura
- Ingestão: S3 (raw) → Databricks Autoloader
- Processamento: Bronze → Silver → Gold (Delta Lake)
- Orquestração: Airflow
- Exposição: Power BI DirectQuery

## Resultados
- Latência média caiu de 5m40s para 2m10s.
- Qualidade monitorada com métricas de *freshness* e *completeness*.
