
# Behavior Charter

- Produce **commit-ready code**: properly formatted, lint-clean, consistent migrations and typing.
- **DRY without over-abstraction**: extract only if it removes real duplication (≥2 usages) or clearly simplifies the code.
- **Minimal changes**: no large or unrelated refactors unless explicitly requested.
- **Assumptions**: if information is missing but not blocking, make a reasonable decision and clearly state it in the recap.
- **Security**: never introduce secrets, hardcoded keys, or logs containing sensitive data.

---

# Standard Workflow

1. Understand the request and identify the relevant files.
2. Propose a plan.
3. Implement changes in small, focused increments.
4. Verify using project commands if they exist (lint / typecheck / tests / build).
5. Recap: files touched, commands run, and points of attention.

---

# Definition of Done

- Lint passes (if applicable)
- Typecheck passes (if applicable)
- Tests pass (if applicable)
- Build passes (if applicable)
- Docs and/or migrations updated (if applicable)
- No secrets or debug leftovers

---

# Editing Rules

- Always **reuse existing functions** before creating new ones.
- Prefer **small PRs**: one intent, one change.
- No “free” large refactors for small tasks.
- Avoid abstractions unless they have **at least two real usages**.

---

# General Conventions

- **Style & formatting**: Format code using the tools configured by the project.
- **Quality**: Linting is mandatory; no silent `any` or leftover `TODO`; explicit error handling.
- **Tests**: If you modify X, add or update the corresponding test Y (if applicable).
- **Logging**: Consistent format and level; avoid noisy logs and sensitive data.
- **Naming**: Follow project naming conventions for files, functions, and variables.

# Docker Execution Rules

- Sometimes, services are expected to run inside **Docker containers**.
- If that's the case, **the container is the source of truth** for execution and verification.
- Prefer running commands **inside the relevant container** rather than locally.
- Prefer `docker compose exec <service>` when the service is already running.
- If multiple services are possible, choose the most likely one and **state the assumption clearly** in the recap.

# Guardrails

- **Never** modify 20 files if 2 are sufficient.
- No global renaming or massive formatting unless it is the explicit goal.
- For every change, always provide:
    - **Why** (one sentence)
    - **Impact** (what it improves or what it might break)
    - **How to verify** (1–3 relevant commands, preferably via Docker)
        

# Extras

@RTK.md
