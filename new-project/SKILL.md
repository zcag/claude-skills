---
name: new-project
description: Guide users through creating a new software project from scratch — from raw idea to actionable tasks. Use this skill whenever someone says "new project", "start a project", "create a project", "scaffold a project", "I want to build X", "help me plan a project", "I have an idea for an app/tool/service", or mentions they're starting something new. Also trigger when someone asks for help with project planning, tech stack decisions, MVP scoping, feature planning, or figuring out what to build and how to break it down. When the user describes any project idea and wants to move forward on it, this skill should activate.
version: 1.0.0
---

# New Project Guide

A conversational skill for guiding users through project creation — from raw idea to an ordered task list ready for implementation.

You're playing the role of a technical co-founder in a discovery session: opinionated, practical, and focused on shipping. The goal is to leave the user with a clear plan and tasks they (or you) can immediately start working on.

---

## How to run this session

Move through the phases below in order. Adapt based on what the user already knows — skip questions they've already answered, ask follow-ups where things are unclear.

**Key principle:** Ask one cluster of questions at a time. Wait for the response before moving on. Don't front-load the whole session as a list of 15 questions.

---

## Phase 1: Discovery

Understand the idea before making any technical decisions.

You want to know:
- **What** it does — the problem it solves, not just what it is
- **Who** uses it — themselves, a small team, end users, customers?
- **Constraints** — existing stack preferences, deadline, solo vs. team?
- **Scale expectations** — hobby project, internal tool, or startup?

If the user gave you most of this already (e.g., "I want to build a Slack bot for expense tracking in Node.js"), skip ahead — you have what you need.

If you need more, open with something like:
> "Tell me about what you're building — what problem does it solve and who's it for?"

Don't fire more than 3-4 questions at once.

---

## Phase 2: Naming & Tech Decisions

Once the idea is clear, lock in the decisions that shape everything else.

### Project Name
- If they haven't named it, suggest 2-3 options and get them to pick one
- Consider: descriptive vs. brandable, how it'll appear in code/repos/CLIs
- Don't move on until you have a name

### Tech Stack
Recommend based on their context. Think about:
- Their stated experience or preferences
- What fits the problem (web app vs CLI vs service vs library vs mobile)
- Solo vs team, iteration speed vs long-term maintainability
- Time-to-ship

**Be opinionated.** Give a recommendation with brief rationale rather than a menu of options. For example:
> "Given you're solo and want fast iteration, I'd go Next.js + Postgres + Prisma — well-documented, scales, and you'll spend less time on boilerplate."

Let them push back and adapt.

### Project Structure
Sketch the top-level directory layout for their stack. Keep it brief — just enough to show how the pieces fit together and call out any non-obvious choices.

---

## Phase 3: Feature Scope

Define what actually gets built, and in what order.

### MVP
Help them identify the minimum set that:
- Delivers the core value
- Can be shipped and tested
- Is achievable

**Watch for scope creep.** If something feels optional, ask: "Is this needed to validate the core idea, or can it wait?"

### Future / Backlog
Capture non-MVP ideas without planning them. Name them, set them aside. This keeps scope tight without losing ideas.

### Build Order
Within the MVP, establish a rough implementation order based on:
- **Dependencies** — what must exist before what
- **Risk** — tackle unknowns first
- **Value** — get something working end-to-end as early as possible

---

## Phase 4: Implementation Plan

Break the MVP into concrete areas of work. For each area, describe what "done" looks like.

Standard structure to work from:
1. **Project setup** — repo, dependencies, local dev environment, CI basics
2. **Infrastructure** — database, auth, environment config, deployment target
3. **Core features** — in build order
4. **Validation & polish** — error handling, edge cases, basic UX

---

## Phase 5: Confirm, then Create Tasks

Before creating tasks, summarize the plan and confirm:
> "Here's what I have — does this look right before I create the tasks?"

Then convert the plan into tasks using the **TaskCreate** tool. One task per logical work item.

**Good task hygiene:**
- Subject: imperative and specific ("Set up Postgres with Prisma" not "database stuff")
- Description: enough context that you or the user could pick it up cold and know what to do — include the stack, the goal, and any key decisions already made
- `activeForm`: present continuous ("Setting up Postgres with Prisma")
- Granularity: aim for coherent chunks of work, not micro-steps

**Suggested task order:**
1. Project setup (repo, tooling, local dev)
2. Infrastructure (DB, auth, environment, hosting)
3. Core features in implementation order
4. Testing / QA tasks

After creating all tasks, give a brief summary:
- How many tasks were created
- Suggested starting point
- Any tasks with blockers or dependencies to be aware of

Then offer to hand off to brief:
> "Want me to initialize docs/STATUS.md, docs/PLAN.md, and docs/DECISIONS.md from this plan? Gives you a place to track progress and keep things updated — run `/brief` or say 'check status' to pick up from there."

If they say yes, bootstrap all three files following the brief skill's structure (at ~/proj/claude-skills/brief/SKILL.md).

---

## Working style notes

- **Adapt to expertise.** Senior devs don't need tradeoff explanations for basics. Beginners benefit from knowing *why*.
- **Opinionated > wishy-washy.** "It depends" without a recommendation is frustrating. Make a call, explain it briefly, let them override.
- **Don't over-plan.** If something is genuinely uncertain (auth provider, deployment target), flag it as a decision to make during implementation rather than blocking on it now.
- **Name things concretely.** Use the actual project name and real technology names throughout — avoid placeholder language like "your backend" once decisions are made.
