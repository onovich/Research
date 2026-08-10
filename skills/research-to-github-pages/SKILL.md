---
name: research-to-github-pages
description: Validate, publish, and troubleshoot static research-report repositories on GitHub Pages with the official GitHub Actions pipeline. Use when Codex must deploy HTML research reports, add or repair a Pages workflow, migrate from branch publishing to Actions, diagnose Pages 404s or broken assets, monitor a Pages build, or verify custom-domain and project-site URLs.
---

# Research to GitHub Pages

Publish a validated research site through an auditable GitHub Actions deployment, then verify the real public pages instead of assuming that a successful push means a live site.

## Workflow

1. Inspect the repository, current branch, remote, dirty files, static entry point, report subdirectories, shared assets, and any local validation or build commands.
2. Inspect the live Pages state with GitHub CLI or the GitHub API. Record the publishing mode, configured custom domain, default branch, existing workflows, recent runs, and expected project-page path.
3. Run the repository's validation gate. For generated sites, run the production build and inspect its output directory. Do not publish a failing build unless the user explicitly requests a diagnostic commit.
4. For a plain static research repository, copy [deploy-pages.yml](assets/deploy-pages.yml) to `.github/workflows/deploy-pages.yml`. Adapt the branch, validation command, and artifact path without weakening the permission boundary. For a built site, upload only the production output directory.
5. Check current official GitHub documentation before changing action major versions. Preserve separate build and deploy jobs, the `github-pages` environment, the deployment URL output, concurrency control, and least-privilege permissions.
6. Review the exact diff and stage only the intended workflow, skill, validation, and documentation files. Never stage unrelated workspace content or force-push.
7. Commit and push the authorized branch. Monitor the exact run through completion and inspect failed job logs rather than repeatedly guessing from the public URL.
8. Verify HTTP success for the canonical root, each report route, both language pages, and representative CSS and JavaScript assets. If a custom domain is configured, verify its DNS, certificate state, canonical path, and HTTPS behavior as well.

## Remote-setting boundary

Changing the repository's Pages source, custom domain, branch protection, environment protection, or DNS is a remote configuration mutation. Obtain user authorization before changing it. A workflow deployment requires `Settings -> Pages -> Source: GitHub Actions`.

Do not add, remove, or replace `CNAME` merely because a custom domain appears in the Pages API. Treat repository files, Pages settings, and DNS as three separate states and preserve the user's intended domain.

## Failure routing

- **404 with no workflow runs:** confirm that the workflow exists on the triggering branch and Pages uses GitHub Actions.
- **Failed workflow:** inspect the failing step, permissions, artifact format, environment approval, and build output.
- **Root works but a report route fails:** inspect the artifact tree, filename case, directory index, and relative links.
- **HTML works but assets fail:** inspect absolute paths, framework base paths, and the repository subpath.
- **Custom domain fails:** inspect Pages API state, DNS target, certificate, HTTPS enforcement, and whether another repository claims the domain.
- **Run succeeds but URL is stale:** use the deployment output URL, bypass local cache, and compare both the GitHub project URL and configured custom domain.

## Completion gate

Do not report success until the deployment run is successful and the intended public URLs return usable HTML with their local assets. Report the commit, workflow run, Pages mode, verified URLs, custom-domain state, validation commands, and any remaining limitation.

## Safety

- Never expose GitHub tokens, credentials, private repository URLs, or local identity data in workflow files or skill resources.
- Never overwrite an existing deployment strategy without reviewing it and confirming scope.
- Never claim that DNS, certificate approval, a pushed commit, or an uploaded artifact alone proves the site is live.
- Preserve unrelated changes in dirty worktrees.
