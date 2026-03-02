# claude-skills

Personal skills for [Claude Code](https://claude.ai/code).

## Install

```bash
make install
```

Symlinks each skill directory into `~/.claude/skills/`. Restart Claude Code after installing.

## Uninstall

```bash
make uninstall
```

## Status

```bash
make list
```

## Skills

### `brief`
Runs an iterative planning session for the current project. Maintains `docs/STATUS.md`, `docs/PLAN.md`, and `docs/DECISIONS.md`.

Trigger: `/brief` or say "run a brief", "check status", "what's next"

### `new-project`
Guides through creating a new project — from raw idea to actionable tasks. Covers discovery, naming, tech stack, scope, and plan.

Trigger: `/new-project` or describe a new project idea

### `jira-sync`
Syncs brief tasks with Jira. Pulls ticket statuses back into STATUS.md, pushes new tasks as tickets.

Trigger: `/jira-sync`

### `git`
Git and GitHub companion for implementation sessions. Governs commit discipline, branch strategy, and PR creation. Applied automatically during `[build]` task implementation from brief — no explicit invocation needed mid-session.

Trigger: `/git` or proactively during implementation
