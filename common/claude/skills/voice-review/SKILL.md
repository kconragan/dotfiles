# voice-review

Review accumulated writing feedback and propose updates to the Voice of Kai document.

## When to use

- When prompted by the skill auditor (every 14 days)
- After a stretch of writing sessions where voice feedback was given
- Any time you want to check whether the voice document still matches reality
- After publishing new writing that might reveal patterns not yet captured

## How it works

The Voice of Kai document (`~/.claude/skills/voice-of-kai/voice-of-kai.md`) describes how
Kai writes. It evolves through a feedback loop:

1. During writing sessions, Claude saves feedback memories when Kai reacts to voice
   ("that doesn't sound like me," "yes exactly," corrections to tone or phrasing)
2. Those memories accumulate in the memory system with `voice-` prefix in filenames
3. This skill reads them, compares against the current document, and proposes changes

## Steps

### 1. Gather feedback signals

Read all memory files matching the pattern `voice-*.md` from the project memory
directory (`~/.claude/projects/*/memory/`). These are writing-session feedback entries
tagged with the `voice-` prefix.

For each entry, note:
- What was the feedback? (correction, confirmation, new pattern)
- Which register was it in? (travel, technical, professional, opinion, journal)
- Does it contradict, extend, or confirm something in the current voice document?

### 2. Scan for new writing

Check for recently published or modified writing in:
- `/Users/kai/Code/github.com/conragan/src/content/posts/`
- `/Users/kai/Documents/Obsidian/kconragan/` (root files only)

Compare any new pieces against the voice document's claims. Look for:
- Patterns that appear consistently but aren't documented
- Documented patterns that the new writing contradicts
- Register-specific behaviors not yet captured in the Register Map

### 3. Read the current voice documents

Read both files in `~/.claude/skills/voice-of-kai/`:
- `voice-of-kai.md` — the core voice and mechanics document
- `voice-antipatterns.md` — banned phrases and dead constructions

For each section, check whether accumulated feedback or new writing evidence supports,
contradicts, or extends what's written. New banned phrases or AI-coded language
patterns should be added to `voice-antipatterns.md`, not the main document.

### 4. Propose changes

Present findings as a structured report:

```markdown
## Voice Review — YYYY-MM-DD

### Feedback signals reviewed
- N feedback memories since last review
- [List each with one-line summary]

### New writing scanned
- [List any new pieces found, with register and date]

### Proposed updates to voice-of-kai.md

#### Confirmed (no change needed)
- [Sections where feedback/evidence reinforces current text]

#### Corrections
- **Section:** [name]
- **Current text:** [quote]
- **Evidence:** [what feedback or writing shows]
- **Proposed change:** [specific edit]

#### Additions
- **Pattern:** [description]
- **Evidence:** [from feedback or new writing]
- **Where it belongs:** [which section]

#### Open questions for Kai
- [Anything ambiguous that needs Kai's input]
```

### 5. Apply approved changes

After Kai reviews the report and approves changes:
- Edit voice-of-kai.md with the approved updates
- Update the "Last validated" date at the bottom of the document
- Archive processed feedback memories by adding `(reviewed YYYY-MM-DD)` to their
  description field
- Update this skill's meta.json

### 6. Run diagnostic lenses (optional)

If Kai has a draft in progress, offer to run it through the diagnostic lenses
defined in the voice document's "Diagnostic Lenses" section. This serves double
duty: it helps the current draft and generates new feedback signal for future reviews.

## Notes

- Never auto-apply changes to the voice document. Always present and get approval.
- The voice document is descriptive, not prescriptive. Changes should reflect how Kai
  actually writes when he's writing well, not how a writing teacher thinks he should.
- When feedback contradicts the document, check whether the feedback represents a
  genuine shift in Kai's voice or a one-off reaction. Look for patterns across
  multiple sessions before proposing structural changes.
- Feedback memories with no `voice-` prefix may still be relevant if they touch on
  writing style. Use judgment, but don't trawl through all memories every time.
