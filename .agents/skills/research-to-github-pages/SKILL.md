---
name: research-to-github-pages
description: Validate, privacy-bound, SEO-check, publish, and troubleshoot static research-report repositories on GitHub Pages with the official GitHub Actions pipeline. Use when Codex must deploy HTML research reports, prevent repository-only files from entering Pages, add or repair a Pages workflow, diagnose 404s or broken assets, monitor a build, or verify custom-domain and project-site URLs.
---

# Research to GitHub Pages

Publish a validated research site through an auditable GitHub Actions deployment, then verify the real public pages instead of assuming that a successful push means a live site.

## Workflow

1. Inspect the repository, current branch, remote, dirty files, static entry point, report subdirectories, shared assets, and any local validation or build commands.
2. Inspect the live Pages state with GitHub CLI or the GitHub API. Record the publishing mode, configured custom domain, default branch, existing workflows, recent runs, and expected project-page path.
3. Define the public surface before building. Use `public-site.json` as a file allowlist, copy [Build-PublicResearchSite.ps1](assets/Build-PublicResearchSite.ps1) to `scripts/`, and adapt [public-site.example.json](assets/public-site.example.json). Prefer a dedicated `site/` source tree that mirrors deployed URLs, set it as the manifest `source`, and keep research Markdown in `reports/`. Include only reader pages, share images, sitemap, favicon, CSS, and runtime JavaScript. Exclude notebooks, README files, docs, skills, scripts, templates, local configuration, and hidden directories.
4. Run the repository's privacy and validation gate, then build the artifact. Inspect the exact artifact tree and scan it again for credentials, emails, personal names, account identifiers, local paths, private URLs, private IPs, and development-only files.
5. Copy [deploy-pages.yml](assets/deploy-pages.yml) to `.github/workflows/deploy-pages.yml`. Adapt the branch and validation command without changing the `_site` artifact boundary. Never upload the repository root.
6. Check current official GitHub documentation before changing action major versions. Preserve separate build and deploy jobs, the `github-pages` environment, deployment URL output, concurrency control, and least-privilege permissions.
7. Run the SEO gate on every indexable locale page: unique title and description, one `h1`, absolute HTTPS canonical, fully qualified reciprocal `hreflang` for `en`, `zh-CN`, and `x-default`, index/follow directive, Open Graph, Twitter Card, valid JSON-LD, favicon, internal links, and sitemap parity. Do not auto-redirect by browser language; keep explicit language links crawlable.
8. Review the exact diff and stage only intended files. Commit and push the authorized branch. If history contains published secrets or local identity data and the user authorized sanitization, create a verified bundle backup, rewrite only the confirmed targets, use force-with-lease, and verify all refs afterward.
9. Monitor the exact run through completion and inspect failed logs. Verify HTTP success for canonical pages, locale pages, sitemap, share images, CSS, and JavaScript. Verify that representative excluded paths return 404.
10. For a custom domain, verify DNS, certificate state, canonical path, HTTP-to-HTTPS behavior, and HTTPS enforcement. Treat search-engine submission as a separate account-bound action.

## Remote-setting boundary

Changing the repository's Pages source, custom domain, branch protection, environment protection, or DNS is a remote configuration mutation. Obtain user authorization before changing it. A workflow deployment requires `Settings -> Pages -> Source: GitHub Actions`.

Do not add, remove, or replace `CNAME` merely because a custom domain appears in the Pages API. Treat repository files, Pages settings, and DNS as three separate states and preserve the user's intended domain.

Enabling HTTPS enforcement changes remote Pages configuration. Do it only when the user has authorized deployment or hardening, the certificate is healthy, and HTTPS already serves the intended site.

## Failure routing

- **404 with no workflow runs:** confirm that the workflow exists on the triggering branch and Pages uses GitHub Actions.
- **Failed workflow:** inspect the failing step, permissions, artifact format, environment approval, and build output.
- **Root works but a report route fails:** inspect the artifact tree, filename case, directory index, and relative links.
- **HTML works but assets fail:** inspect absolute paths, framework base paths, and the repository subpath.
- **Repository-only files are public:** stop uploading `.`; build `_site` from an explicit allowlist, deploy it, and verify old paths now return 404.
- **Locale pages compete or redirect:** use self-canonical locale URLs, reciprocal absolute `hreflang`, and manual language links without automatic locale redirects.
- **Custom domain fails:** inspect Pages API state, DNS target, certificate, HTTPS enforcement, and whether another repository claims the domain.
- **Run succeeds but URL is stale:** use the deployment output URL, bypass local cache, and compare both the GitHub project URL and configured custom domain.

## Completion gate

Do not report success until the deployment is successful, HTTPS serves the site, intended public URLs return usable content, excluded paths return 404, and the live HTML contains the expected canonical metadata. Report the commit, run, Pages mode, artifact boundary, verified URLs, HTTPS state, sitemap URL, validation commands, and any account-bound submission still outstanding.

## Safety

- Never expose GitHub tokens, credentials, private repository URLs, or local identity data in workflow files or skill resources.
- Never overwrite an existing deployment strategy without reviewing it and confirming scope.
- Never claim that DNS, certificate approval, a pushed commit, or an uploaded artifact alone proves the site is live.
- Preserve unrelated changes in dirty worktrees.
