## Supporting Kubb

Kubb uses an MIT-licensed open source project with its ongoing development made possible entirely by the support of Sponsors. If you would like to become a sponsor, please consider:

- [Become a Sponsor on GitHub](https://github.com/sponsors/stijnvanhulle)

<p align="center">
  <a href="https://github.com/sponsors/stijnvanhulle">
    <img src="https://raw.githubusercontent.com/stijnvanhulle/sponsors/main/sponsors.svg" alt="My sponsors" />
  </a>
</p>

## Repository settings

Every kubb-labs repo uses the same settings: squash merge only (PR title and body become the commit), auto-merge, the update-branch button, and branches deleted after merge. Wiki and Projects are off. Each repo also gets the same base labels, and repo-specific labels stay.

To apply them to a new repo or fix drift, run this as an org admin:

```bash
./scripts/sync-repos.sh            # all repos
./scripts/sync-repos.sh my-new-repo  # one repo
```
