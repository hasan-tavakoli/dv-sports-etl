# dv-sports-etl

A sample per-domain dbt project for the **sports** domain, targeted by an automated dbt-model-generation agent system. It holds dbt models, sources, and a CI/CD workflow that publishes new builds back into the system.

> **One of four repos in a two-agent system** — see the full architecture in the main repo: [dbt-factory-agent](https://github.com/hasan-tavakoli/dbt-factory-agent)

## Role in the system

- **Orchestrator → PR**: the orchestrator agent opens `model_only` pull requests here, containing generated dbt SQL and `_schema.yml` changes on a `feature/*` branch.
- **Merge → CI → Pub/Sub → config-agent**: once a PR merges into `main`, the `.github/workflows/ci.yml` workflow builds a Docker image, pushes it to the container registry (`ghcr.io`), and — for pushes to `main` — publishes an event to the `dv-model-image-ready` Pub/Sub topic containing the new image reference. That event wakes the config-agent, which updates the deployed image for this domain.

## Repo structure

```
dbt/
  models/
    public/            # dbt models + their _schema.yml (e.g. avg_bet_per_player)
    sources/
      _sources.yml      # source table definitions (raw_sports.games, raw_sports.bets)
.github/
  workflows/
    ci.yml              # build & push Docker image; publish Pub/Sub event on main
.agent-metadata.json     # domain/target metadata read by the CI workflow
```

The working branch is `main`.

## Note

This is a deliberately minimal sample domain used to demonstrate the end-to-end orchestrator → PR → CI → Pub/Sub → config-agent loop — not a full production dbt project.
