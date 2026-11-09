# Upstream relationship

This repository is the Nzumari Studio downstream fork of [musescore/MuseScore](https://github.com/musescore/MuseScore).

## Source of truth

- Upstream repository: https://github.com/musescore/MuseScore
- Upstream branch: `main`
- Downstream repository: https://github.com/Tksagake/Nzumari-Studio
- Downstream integration branch: `main`
- Product development branch: `nzumari/architecture-foundation`

The fork must retain the complete upstream Git history. Do not replace it with an unrelated repository, squash the upstream history, or routinely rebase published Nzumari work in a way that obscures ancestry.

## Local remotes

A local clone should have both remotes:

```bash
git clone --recurse-submodules https://github.com/Tksagake/Nzumari-Studio.git
cd Nzumari-Studio
git remote add upstream https://github.com/musescore/MuseScore.git
git fetch --all --tags
git submodule update --init --recursive
```

Verify:

```bash
git remote -v
git log --oneline --decorate -8
git merge-base main upstream/main
```

The `origin` remote is the Nzumari repository. The `upstream` remote is the official MuseScore repository. Do not push to upstream.

## Update procedure

1. Fetch upstream without modifying the working branch: `git fetch upstream --tags`.
2. Create a dated integration branch from the current Nzumari `main`.
3. Merge the selected upstream `main` commit into that branch; do not force-push.
4. Update submodules deliberately and review their pinned commits.
5. Resolve conflicts, especially in files modified by Nzumari.
6. Run the agreed build, unit, integration and packaging checks.
7. Open a pull request into Nzumari `main` with the upstream range, conflict summary and test evidence.
8. Merge only after review.

Never auto-merge upstream changes directly into a release branch.

## Change-isolation policy

- Prefer new Nzumari modules, services, QML components and resource bundles.
- Keep notation, engraving, playback and import/export behaviour upstream-compatible.
- Avoid editing shared MuseScore files when an extension point, module registration or adapter can achieve the same result.
- When a shared upstream file must change, keep the patch small, document why, and record the upstream file/function affected.
- Do not modify the `muse` or `muse_deps` submodule contents as though they were vendored source. Changes to those projects require their own explicit upstream/downstream strategy.

## Baseline and release records

For each release, record:
- MuseScore upstream commit SHA.
- `muse_framework` and `muse_deps` submodule SHAs.
- Nzumari commit SHA.
- Build environment and Qt/compiler versions.
- Test results and known deviations.

This file documents the intended workflow. Verify remotes and fork ancestry in a local clone before the first upstream integration.
