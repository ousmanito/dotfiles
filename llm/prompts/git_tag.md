---
name: git tag
interaction: chat
description: Suggest the next SemVer-style tag
opts:
  auto_submit: true
  adapter:
    name: openai
---

## user

- You are using a `0.x.y` version line.  
- **Never bump the major digit (`0`) unless explicitly stated.**
- **For every `feat:` commit, increment the "minor" digit (`x`)** (e.g., `0.0.70` → `0.1.0`).
- **For `fix:` and all other non-feature commits, increment only the "patch" digit (`y`)** (e.g., `0.1.0` → `0.1.1`).
- Never increment the major digit unless I say so.
- Latest tag: `${git.latest_tag}`
- Commits since that tag (listed **newest first**):
```
${git.log_since_latest}
```

Staged diff:
```diff
${git.diff}
```

1. Decide whether we should stay in the same minor or bump it (only use `feat` when I’ve approved one).
3. Give me the combined `git tag <tag> <commit>` commands using the commit IDs from previously so I can create them manually in one shot if there are many

