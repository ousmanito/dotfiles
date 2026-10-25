---
name: git commit
interaction: chat
description: Generate a commit message using Conventionnal Commits syntax
opts:
  auto_submit: true
  adapter:
    name: openai
---

## user

Generate a Conventional Commit for the staged diff below. Avoid `feat:` for 0.x releases **unless** I have just confirmed it’s a feature. Follow these rules:

- Only use other types (fix, chore, docs, etc.) unless you explicitly got permission.

```diff
${git.diff}
```
