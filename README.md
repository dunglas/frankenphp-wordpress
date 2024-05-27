# WordPress on FrankenPHP

> [!CAUTION]
> This repository has been deprecated in favor of [FrankenWP](https://github.com/StephenMiracle/frankenwp),
> an enterprise-grade WordPress image built using FrankenPHP.

Run the popular [WordPress CMS](https://wordpress.org) on top of [FrankenPHP](https://frankenphp.dev),
the modern app server for PHP.

## Getting Started

```
git clone https://github.com/dunglas/frankenphp-wordpress
cd frankenphp-wordpress
docker compose pull --include-deps
docker compose up
```
Your WordPress is available on `https://localhost`.
Check `docker-compose.yml` to find DB credentials.
