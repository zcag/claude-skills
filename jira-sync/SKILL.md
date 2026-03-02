---
name: jira-sync
description: Sync brief tasks with Jira — push unsynced tasks as tickets, pull current ticket statuses back into STATUS.md. Trigger on "sync jira", "sync with jira", "push to jira", "check jira status", "jira sync", or when the user wants to create Jira tickets from their brief task list or check ticket progress. Use proactively when the user mentions Jira in the context of a project that has a docs/STATUS.md.
version: 1.0.0
---

# Jira Sync

Bridges the brief task list and Jira. Two directions: push unsynced tasks as new tickets, pull ticket statuses back into STATUS.md.

Short and to the point. Ask before creating anything.

---

## Every session

1. **Find project config** — read `docs/DECISIONS.md` for a `[source]` entry with a Jira project key. If not found, ask (see Setup below).
2. **Pull first** — query Jira for any tasks already synced (have a ticket ID in STATUS.md). Update their status inline.
3. **Push** — show unsynced tasks, ask which to create tickets for. Never auto-create.
4. **Log** — record the sync in DECISIONS.md.

---

## Setup (first run)

If no Jira project key found in DECISIONS.md:

1. Call `getAccessibleAtlassianResources` to get available sites
2. Ask: "Which Jira project should this sync to?" — show available projects via `getVisibleJiraProjects`
3. Once confirmed, save to DECISIONS.md:
   ```
   - YYYY-MM-DD: [source] Jira project: BILL — site: company.atlassian.net — cloudId: xxx
   ```

---

## Pull: Jira → STATUS.md

For each task in STATUS.md that has a ticket ID (e.g., `(BILL-42)`):

1. Fetch current status via `getJiraIssue`
2. Update STATUS.md inline — append status after the ticket ID:
   ```
   - [build] Set up Postgres schema (BILL-42 · In Progress)
   - [build] Scaffold Rails app (BILL-41 · Done)
   ```
3. Move tasks marked **Done** from "Tasks" into "Current state" in STATUS.md with a note.

---

## Push: STATUS.md → Jira

1. Show all unsynced tasks (no ticket ID) as a numbered list
2. Ask: "Which of these should become Jira tickets?" — user picks by number or says "all"
3. For each confirmed task, create via `createJiraIssue` with a structured description (see Description template below). Default issue type: Task. Only ask if user specifies otherwise.
4. Write the ticket ID back into STATUS.md inline: `- [build] Set up Postgres schema (BILL-42)`
5. Log to DECISIONS.md:
   ```
   - YYYY-MM-DD: [source] Synced tasks to Jira: BILL-42, BILL-43, BILL-44
   ```

### Description template

Every ticket description must include:

```
**Type:** [build | spike | clarify]
**QA Testable:** [Yes | No] — [one-line reason]

## Description
What this task is and why it matters. Include any context the assignee needs to pick it up cold.

## Pointers
- Relevant files, sample data, docs sections, related tickets
- Where findings/output should go (if a spike or clarify)

## Acceptance Criteria
- [ ] Specific, verifiable done criteria — not "analyze the thing", but "X is documented in Y"
```

**QA Testable heuristic:**
- **Yes** — produces a runnable artifact a tester can interact with (UI, API, CLI output, log file)
- **No** — internal dev work: analysis spikes, config, scaffolding, research, documentation tasks
- When in doubt, lean **No** — don't claim testability that isn't real

**Testability label:** add `not-testable` or `testable` via `additional_fields: {"labels": [...]}` so it's filterable in Jira.

**Pointers:** always include file paths, doc section names, and where the output of this task should land. A ticket with no pointers is a ticket someone will ignore.

---

## STATUS.md task format with ticket IDs

```markdown
## What's next
**Blockers**
- waiting on DB credentials (BILL-38 · Blocked)

**Tasks**
- [clarify] Confirm invoice numbering with client (BILL-39 · To Do)
- [spike] Test Grover PDF rendering on Hetzner (BILL-40 · In Progress)
- [build] Set up Postgres schema (BILL-42 · To Do)
- [build] Scaffold Rails app              ← no ID yet = unsynced
```

---

## Rules

- Never create tickets without explicit confirmation
- Never modify ticket content in Jira (descriptions, assignees, etc.) — only create and read
- Don't duplicate: if a task already has a ticket ID, skip it in the push step
- Keep STATUS.md readable — ticket IDs are inline annotations, not clutter
- If Jira is unreachable or auth fails, say so clearly and stop — don't partially update STATUS.md
