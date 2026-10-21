#!/usr/bin/env bash
# Applies the shared GitHub settings and base labels to every kubb-labs repo.
# Run as an org admin: ./scripts/sync-repos.sh [repo...]
set -euo pipefail

ORG=kubb-labs
REPOS=("$@")
[ ${#REPOS[@]} -eq 0 ] && REPOS=(kubb plugins config action platform registry .github)

# name|color|description
LABELS=(
  "bug|d73a4a|Something isn't working"
  "dependencies|0366d6|Pull requests that update a dependency file"
  "documentation|0075ca|Improvements or additions to documentation"
  "duplicate|cfd3d7|This issue or pull request already exists"
  "enhancement|a2eeef|New feature or request"
  "feature|ededed|"
  "good first issue|7057ff|Good for newcomers"
  "help wanted|008672|Extra attention is needed"
  "invalid|e4e669|This doesn't seem right"
  "question|d876e3|Further information is requested"
  "wontfix|ffffff|This will not be worked on"
)

for repo in "${REPOS[@]}"; do
  echo "== $ORG/$repo"
  gh api -X PATCH "repos/$ORG/$repo" --silent \
    -F allow_squash_merge=true \
    -F allow_merge_commit=false \
    -F allow_rebase_merge=false \
    -f squash_merge_commit_title=PR_TITLE \
    -f squash_merge_commit_message=PR_BODY \
    -F allow_auto_merge=true \
    -F delete_branch_on_merge=true \
    -F allow_update_branch=true \
    -F has_wiki=false \
    -F has_projects=false

  # Creates or updates the base set; repo-specific labels stay untouched.
  for label in "${LABELS[@]}"; do
    IFS='|' read -r name color description <<<"$label"
    gh label create "$name" --repo "$ORG/$repo" --color "$color" --description "$description" --force
  done
done
