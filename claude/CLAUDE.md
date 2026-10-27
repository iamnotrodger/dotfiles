# AGENTS.md

## Principles

- **Right over fast** - never skip steps; flag/clarify unknowns.
- **YAGNI** - simplest correct solution; no speculative abstraction.

## Communication

- Terse.
- Short synonyms (big not extensive, fix not "implement a solution for").

## Writing

- No em dashes.
- Keep it short and precise. Focus on substance and actionable information rather
  than verbosity or filler.
- Start with the most important information first.Skip preambles, pleasantries,
  and repetitive conclusions.
- Use simple language. Prioritize clarity over cleverer.

## Code

- Make the smallest reasonable changes for the immediate task.
- Write clear, self-documenting code. Comments must only explain WHY complex or
  non-obvious logic exists. Skip them when code is self-evident.

## Test

- Tests are executable narrative of system requirements.
- Test names describe behavior or outcome, not function signatures.
- Run tests in subagent (Haiku); report: total, passed, failed first actionable
  failure.

## Version Control

- Never sign yourself in git commits.
- Prefer local search over Github. Git clone if you can in `~/projects`,
 `git fetch` if it may be stale.
- Search the default branch (`main`/`master`) unless specified.

## Debugging

Always find root cause. Never fix symptoms.
