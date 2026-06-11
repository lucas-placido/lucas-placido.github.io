---
layout: project
title: "Buscador de Vagas: pipeline ELT + RAG"
date: 2026-06-10
summary: "Pipeline ELT que agrega vagas remotas de tech de 5 APIs, modela com dbt no BigQuery, orquestra com Airflow e expõe busca semântica + RAG sobre as descrições."
repo: "https://github.com/lucas-placido/buscador-de-vagas"
thumbnail: /assets/images/buscador-de-vagas.svg
tags: ["dbt","BigQuery","Airflow","Terraform","RAG","pgvector","FastAPI"]
---

## Objetivo
Coletar vagas remotas de tecnologia de múltiplas fontes públicas, unificar e modelar esses dados num modelo canônico e expor uma camada de **busca semântica/RAG** sobre as descrições — permitindo perguntar em linguagem natural *"quais vagas combinam com meu perfil?"*.

O projeto tem as duas naturezas de dados num caso real: a **parte estruturada** (contagem por stack, senioridade, região), que o dbt modela, e a **parte textual** (descrições), onde embeddings e RAG resolvem um problema concreto — não são enfeite.

## Arquitetura
```
APIs públicas (5 fontes)
        │  ingestão Python (httpx, logs estruturados)
        ▼
BigQuery (raw — payload JSON, particionado)
        │  dbt
        ▼
staging (por fonte) → intermediate (unificação + dedup) → marts (analíticos)
        │  Airflow (DAG diária, Docker)
        ▼
embeddings (sentence-transformers) → pgvector
        │  RAG (Ollama, LLM local)
        ▼
FastAPI — busca semântica · /ask (RAG) · dashboard dos marts
```

- **Ingestão (Python):** Arbeitnow, Himalayas, RemoteOK, Jobicy e apibr.com — cada API com seu schema; carga idempotente por `source_job_id`.
- **Warehouse (BigQuery):** camada raw recebe o dado cru de cada fonte; tier gratuito.
- **Transformação (dbt):** staging tipado por fonte → unificação num modelo canônico (dedup entre fontes, senioridade/localização/salário padronizados) → marts (por stack, por senioridade, BR vs global). Com testes e documentação.
- **Orquestração (Airflow via Docker):** uma DAG roda coleta → carga → `dbt build` → indexação de embeddings, agendada, simulando produção.
- **Camada de IA (pgvector + Ollama):** embeddings das descrições num vector store; o RAG recupera as vagas mais próximas e um LLM local responde com citações.

## Por que RAG (e não busca por palavra-chave)
As fontes usam **vocabulários diferentes para a mesma coisa** — "data pipelines", "ETL development", "orquestração de dados". Busca textual falha nesse cenário heterogêneo; embeddings capturam a proximidade semântica e o RAG responde perguntas em linguagem natural usando as vagas recuperadas como contexto. **A camada de IA resolve um problema que a heterogeneidade das fontes criou.**

## Qualidade e engenharia
- **93 testes Python** (ingestão, RAG, UI) + **64 testes dbt** (not null, unique, accepted values).
- Lint e tipagem estrita: `ruff` + `mypy`.
- **9 ADRs** documentando decisões (ELT vs ETL, Terraform, Airflow local vs Cloud Composer, pgvector + sentence-transformers, UI vanilla).
- **Custo zero / 100% local na camada de IA:** modelos cacheados localmente e infra no tier gratuito.

## Stack
`Python 3.12` · `dbt` · `BigQuery` · `Apache Airflow` · `Docker` · `Terraform` · `pgvector` · `sentence-transformers` · `Ollama` · `FastAPI`
