---
name: git
description: Git and GitHub operations companion for implementation sessions. Apply proactively whenever implementing [build] tasks from brief — commit at logical checkpoints, create PRs when branches are done. Also triggered by explicit requests like "commit this", "open a PR", "create a branch".
version: 1.0.0
---

# git

Handles commits, branches, and pull requests during implementation.

Short and surgical — no walls of text in messages or descriptions, ever.

---

## When to apply

- During `[build]` task implementation — commit at logical checkpoints as work progresses
- When a feature branch is complete — create a PR
- When explicitly asked for any git or GitHub operation

This skill is a companion to `brief`. When `brief` transitions into implementation work, this skill governs all git operations for that session.

---

## Branches

Create a branch for non-trivial `[build]` tasks — anything that warrants a review cycle.

- Naming: `<ticket-key>-<short-description>` if a Jira key is known (e.g., `RED-1-project-skeleton`), otherwise `<short-description>`. Lowercase, hyphens only.
- Branch from main/master unless the task builds on another in-flight branch.

Commit directly to the current branch (no new branch) for: small fixups, config tweaks, doc updates, things that don't need review.

If unclear whether to branch, ask.

---

## Commits

**When to commit:** at logical checkpoints during implementation — not every file save, not only at task completion. A good unit: "wired the new component", "added parse + test", "fixed the config path". One coherent change per commit.

**Message format:**
```
<verb> <what>

<why, if not obvious from the diff>
```

- First line: imperative mood, 50–72 chars. ("add", "fix", "wire" — not "added", "fixed")
- Body: only when the why isn't obvious. Short bullets, no paragraphs.
- No co-author lines, ever.
- No "WIP", "checkpoint", or meta-commentary.

**Before committing:**
1. Run the test suite if one exists — don't commit broken code.
2. Stage specific files, never `git add .` blindly.
3. If the diff includes snapshot or golden-file changes, note it in the commit body if not obvious.

---

## Tests and snapshots

Run tests before every commit. If any fail, fix before committing.

For snapshot or golden-file tests (Jest snapshots, approved files, etc.):

1. Run tests to capture the current baseline before making changes.
2. Make the logic change.
3. Run tests — failing snapshots surface the diff.
4. Review: if the diff is intentional, update snapshots.
5. Commit logic change + snapshot updates together — they're one logical change.

The commit diff is the canonical record of what changed, including test output. Don't squash or separate snapshot updates into a cleanup commit — that hides the causality.

---

## Pull requests

Create a PR when a feature branch is complete and tests pass.

**Title:** short imperative, ticket reference if applicable.
- `RED-1: add project skeleton`
- `fix account probe path resolution`

**Description:**
```
<1-2 sentence summary of what this PR does>

**Changes**
- bullet
- bullet

**Decisions / assumptions**
- any [tech] or [assumed] entries logged during this work
- omit section if nothing to note
```

No test plan checklists. No co-author. No "Generated with Claude Code". No paragraphs.

---

## What not to do

- Don't amend published commits.
- Don't force push to main/master.
- Don't skip hooks (`--no-verify`) unless explicitly asked.
- Don't bundle unrelated changes into one commit.
- Don't create a PR until the branch is ready — no draft PRs unless asked.
