# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Corporate website for Banba Group, a software engineering firm. Built with **Jekyll 4.2.1** on **Ruby 3.0.0**, deployed primarily via **Netlify**.

## Development Commands

```bash
bundle install                    # Install dependencies
bundle exec jekyll serve          # Local dev server at http://localhost:4000
bundle exec jekyll build          # Build site to _site/
rake assets:precompile            # Alternative build (runs jekyll build)
```

Note: `_config.yml` is NOT hot-reloaded — restart the server after changing it.

## Architecture

- **Static site generator**: Jekyll with Minima theme, Kramdown (GFM) markdown
- **Collections**: `_posts/` (blog articles) and `_jobs/` (job listings with custom `job` layout)
- **Pages**: `index.md`, `about.md`, `blog.md`, `jobs.md`, `404.html`
- **Assets**: `assets/css/` (minified CSS + source maps), `assets/js/frontend/` (jQuery 3.4.1, timber.master.min.js)
- **Plugins**: jekyll-feed

## Deployment

- **Primary**: Netlify (auto-deploys from main branch)
- **Alternative**: Docker (Ruby 3.0.0 + nginx) → Google Container Registry → GKE (3-replica deployment with HPA)
- CI/CD configs exist for Jenkins, BuildKite, and Google Cloud Build

## Key Config Files

| File | Purpose |
|------|---------|
| `_config.yml` | Jekyll site settings, collections, excluded files |
| `Gemfile` | Ruby dependencies |
| `config.ru` | Rack config (SSL enforcer + Jekyll middleware) |
| `Dockerfile` | Production container build |
| `nginx.conf` | Production nginx config (caching, SSL, assets) |
| `k8s/production/deployment.yaml` | Kubernetes manifests (Deployment, HPA, ConfigMap, LimitRange) |
