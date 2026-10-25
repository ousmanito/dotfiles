---
name: git add
interaction: chat
description: Let the model decide staging batches
opts:
  auto_submit: true
  adapter:
    name: openai

---

## user

Analyze the unstaged diff and split it into coherent groups. For each group:

1. Describe what it does.
2. List the files.
3. Output `git add file1 file2 …`. Surrond arguments in quote please to avoid shell errors with special characters.
4. Provide a relevant Conventionnal Commit message (don't use feat).

```diff
  ${git.diff_unstaged}
```
