---
layout: default
title: "Projetos — Lucas Plácido"
permalink: /projects/
---
<section class="container container-narrow mx-auto px-6 py-12">
  <h1 class="text-3xl font-bold mb-2 text-[var(--heading)]">Todos os Projetos</h1>
  <p class="text-[var(--muted)] mb-8">Pipelines de dados, lakehouses e camadas analíticas — do ingestão ao consumo.</p>
  <div class="grid md:grid-cols-3 gap-6">
    {% assign allp = site.projects | sort: 'date' | reverse %}
    {% for p in allp %}
      <a href="{{ p.url | relative_url }}" class="card rounded-2xl overflow-hidden flex flex-col">
        {% if p.thumbnail %}
          <img src="{{ p.thumbnail | relative_url }}" alt="{{ p.title }}" loading="lazy"
               class="w-full aspect-[5/2] object-cover border-b" style="border-color: var(--border)"/>
        {% endif %}
        <div class="p-5 flex flex-col gap-2">
          <h3 class="text-lg font-semibold text-[var(--heading)]">{{ p.title }}</h3>
          <p class="text-sm text-[var(--muted)] line-clamp-3">{{ p.summary }}</p>
          {% if p.tags %}
            <div class="mt-2 flex flex-wrap gap-2">
              {% for t in p.tags limit: 4 %}
                <span class="chip px-2 py-1 rounded-lg text-xs">{{ t }}</span>
              {% endfor %}
            </div>
          {% endif %}
        </div>
      </a>
    {% endfor %}
  </div>
</section>
