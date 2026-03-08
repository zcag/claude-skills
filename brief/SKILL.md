---
name: brief
description: Run an iterative project planning session. Trigger on "check status", "brief", "run a brief", "what's next on [project]", "planning session", or when the user wants to orient, plan, or figure out next steps on a project. Takes any state — vague idea, mid-build mess, or existing plan — and acts as analyst/tech lead to produce structured plans and actionable tasks. Maintains docs/STATUS.md, docs/PLAN.md, and docs/DECISIONS.md across sessions. Use this skill proactively whenever someone wants to plan, unblock, or get oriented on a project they're working on.
version: 1.0.0
---

# Brief

You're acting as analyst + project planner + tech lead. Take whatever state the project is in and produce clear next steps plus updated docs.

Short and dense. Informal. No walls of text.

---

## Every session

1. **Orient** — read `docs/STATUS.md`, `docs/PLAN.md`, and `docs/DECISIONS.md` if they exist. Check the task list.
2. **Ask** — based on what you found, ask 2-3 targeted questions. No more. Don't ask things the docs already answer.
3. **Update** — after getting answers, update docs and create/update tasks.

If no docs exist: ask what the project is and what they're trying to figure out, then bootstrap all three files. It's fine if answers are vague or unknown — capture uncertainty as open questions or `[clarified] TBD: ...` entries rather than trying to lock everything down. The goal is enough structure to generate useful tasks, not a complete plan.

---

## Assumptions vs. decisions

A **decision** is something explicitly discussed and confirmed — by the user, in prior conversation, or already in DECISIONS.md.
An **assumption** is something the model filled in to make the plan coherent — not validated, could be wrong.

These are not the same and must never be treated the same.

**In plans and docs:**
- Technical approaches that haven't been explicitly confirmed belong in PLAN.md marked `[assumed]`, not stated as facts
- Log them in DECISIONS.md with the `[assumed]` tag so they're visible and trackable
- `[assumed]` entries should produce `[clarify]` tasks — don't build on them without resolving first

**When moving toward implementation:**
- Before producing build tasks or skeleton outlines, scan the plan for `[assumed]` entries
- If any would meaningfully change the shape of the implementation, surface them: name the assumption, explain what it affects, and ask
- Don't refuse to proceed — just be explicit. A team can choose to proceed on an assumption consciously, that's different from not knowing it's an assumption

**General rule:** when the model chooses something to fill a gap — any domain, any kind of choice — that's an assumption. Name it as one. Don't let it silently become a fact in the next session.

---

## docs/STATUS.md

The running state snapshot. Updated every session. Always in this order:

```markdown
# Status — [Project Name]
_Last updated: YYYY-MM-DD_

## What we're building
One or two sentences.

## What's next
**Blockers**
- ...

**Tasks**
- [clarify] ...
- [spike] ...
- [build] ...

## Current state
What's been done, what's in flight, key decisions made.

## Open questions
Things that need answering but aren't blocking right now.
```

**Rules:**
- "What's next" always sits right after the summary — first thing someone sees
- Read carefully before rewriting — update in place, don't lose context
- When something resolves, move it from "open questions" into "current state" with a brief note — don't delete it
- Bullets only, no paragraphs

---

## docs/PLAN.md

The living technical plan. Always coherent and current. Seed structure:

```markdown
# Plan — [Project Name]
_Last updated: YYYY-MM-DD_

## Overview
What, why, for who. 3-5 sentences.

## Stack & approach
Tech decisions with brief rationale.
```

Sections grow organically — data model, integrations, API design, infra, constraints, whatever this project actually needs.

**Rules:**
- Rewrite sections in place when things change — no stale content
- After updating, reads as one coherent document — not a patchwork
- Dense bullets and short paragraphs, no essays
- No decisions log here — that lives in DECISIONS.md

---

## docs/DECISIONS.md

Append-only log of everything decided, clarified, or scoped. Newest first.

```markdown
# Decisions — [Project Name]

- YYYY-MM-DD: [tech] ...
- YYYY-MM-DD: [business] ...
- YYYY-MM-DD: [scope] ...
- YYYY-MM-DD: [clarified] ...
```

Tags: `[tech]`, `[business]`, `[scope]`, `[clarified]`, `[assumed]`
- `[tech]` — technical approach, stack, architecture choices (explicitly decided)
- `[business]` — product direction, target users, model
- `[scope]` — what's in/out of MVP, feature deferrals, phase cuts
- `[clarified]` — something that was fuzzy and is now resolved
- `[assumed]` — model filled this in to make progress; not yet validated by the team. Should have a corresponding `[clarify]` task.

**Rules:**
- Append only — never edit or remove existing entries
- One line per entry, just enough context to understand it later
- Every session: any decision made or thing clarified gets logged here

---

## Tasks

Use TaskCreate for all tasks. Prefix the subject:
- `[clarify]` — needs a human answer before moving forward
- `[spike]` — research/investigation, time-boxed
- `[build]` — implementation work

Description: enough context to pick up cold. activeForm: present continuous.

Mirror the current task list in STATUS.md "What's next".

**Avoid task dumps.** When multiple open questions belong to the same area, create one `[clarify]` task for that area and list the sub-questions in the description. A task per question is noise. A task per theme is useful.

**`[build]` tasks that depend on unresolved `[assumed]` entries should be created with a blockedBy relationship to the corresponding `[clarify]` task.** This makes the dependency explicit and prevents implementation from silently inheriting assumptions.

---

## What to ask

**Cold start (no docs):**
- What are you building and what's the immediate problem to solve?
- What's already decided vs. what's fuzzy?
- What's blocking you or unclear right now?

**Resuming (docs exist):**
- Which tasks from last session are done?
- Any blockers or open questions that have moved?
- What's changed or new since the docs were last updated?

Never ask more than 3 things at once. If the docs are fresh and tasks are clear, you may not need to ask anything — just confirm and proceed.

**Important:** Open questions and blockers in the docs are there because they need human input — don't resolve them autonomously. If something like "Postgres vs. Firebase" is listed as open, ask the user, don't decide for them.

---

## Creating docs/

If `docs/` doesn't exist, ask first:
> "No docs/ found. Want me to create docs/STATUS.md, docs/PLAN.md, and docs/DECISIONS.md to start tracking this?"

---

## Jira

If the project has a Jira project key in DECISIONS.md, mention at the end of each session:
> "Run `/jira-sync` to push new tasks to Jira or pull ticket statuses."

Don't do the sync yourself — that's jira-sync's job.

---

## Implementation sessions

**Before writing a single line of implementation code**, you MUST call the Skill tool with `skill: "git"`. This is a blocking requirement — do not start implementing until you have done this.

Do this exactly once at the start of the implementation session. The git skill then governs all git operations: when to commit, message format, branch strategy, PR structure.

---

## Handoff from new-project

If there's already a task list from a new-project session but no brief docs, skip discovery questions and bootstrap all three files from the existing context. Just confirm:
> "Looks like there's already a plan here — want me to initialize the brief docs from it?"
