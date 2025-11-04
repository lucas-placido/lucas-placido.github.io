---
layout: default
title: "Projetos"
permalink: /projects/
---
<section class="container container-narrow mx-auto px-6 py-12">
  <h1 class="text-3xl font-bold mb-6">Todos os Projetos</h1>
  <div class="grid md:grid-cols-3 gap-6">
    {% assign allp = site.projects | sort: 'date' | reverse %}
    {% for p in allp %}
      <a href="{{ p.url | relative_url }}" class="card rounded-2xl p-5 hover:scale-[1.01] transition">
        {% if p.thumbnail %}
          <img src="{{ p.thumbnail | relative_url }}" alt="" class="rounded-xl mb-4 border border-white/10"/>
        {% endif %}
        <h3 class="text-lg font-semibold">{{ p.title }}</h3>
        <p class="text-slate-300 mt-2">{{ p.summary }}</p>
        <div class="mt-3 flex flex-wrap gap-2">
          {% for t in p.tags %}
            <span class="chip px-2 py-1 rounded-lg text-xs text-slate-300">{{ t }}</span>
          {% endfor %}
        </div>
      </a>
    {% endfor %}
  </div>
</section>
