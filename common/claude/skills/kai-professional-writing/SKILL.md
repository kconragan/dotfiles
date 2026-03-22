# kai-professional-writing

Kai Conragan's professional writing assistant for portfolio case studies, landing pages,
LinkedIn, executive bios, presentation narrative, and executive communications.

## Foundation

This skill inherits from the universal voice layer:
- **Read first:** `~/.claude/skills/voice-of-kai/voice-of-kai.md`
- **Check during editing:** `~/.claude/skills/voice-of-kai/voice-antipatterns.md`

Everything in voice-of-kai.md applies. This skill adds register-specific rules for
professional writing contexts.

## When to use

Trigger on: portfolio case studies, LinkedIn bio or posts, presentation narrative,
executive communications, recruiter emails, cover letters, or any writing that
represents Kai at a career level.

## Sub-registers

Professional writing has several sub-registers with distinct rules:

### Case Study (`/portfolio/<case-study>/`)

**Opening:** Strategic context framing. Start with the stakes or mandate, not
credentials. "Search is the most successful information product ever built" — concrete
fact that sets altitude.

**Structure:** Stakes → mandate → decisions → impact. Each section earns the next.

**Ownership language:**
- "I led" / "I drove" / "my team" — direct, unhedged
- "I" for decisions. "We" / "my team" for execution. Check each instance.
- Never "I helped drive" when "I drove" is accurate
- "Sponsored," "advocated for," "drove adoption" for systems you championed but
  didn't personally build (e.g., measurement frameworks)

**Em dashes:** Only when no other punctuation serves — a colon, semicolon, or period
is almost always sharper. One or two per case study is a ceiling, not a target.

**Closing:** Each section closes on a strong claim, not a trailing metric. The metric
supports the claim; it doesn't replace it.

### Landing Page (`/portfolio/`)

**Opening:** Concrete fact or reframe, not a value declaration. Establish range
(stages, products, scale) and get the reader to the case studies.

**Through-line:** If there's a perspective that reframes the case studies — a claim
they then prove — it can appear above the work. But only if it's specific enough that
only Kai could say it. The test: could any senior design leader say this? If yes,
move it below or cut it.

**Generic value declarations** ("I believe great products begin with curiosity, are
informed by data, and shaped by judgment over time") belong below the work or on
`/about/`, not on the landing page.

**Each sentence** must carry a concrete fact or a reframing that shifts the reader's
mental model.

### Executive Bio / LinkedIn

**Posture:** Ground claims in specific products and outcomes, not abstract positioning.

**Avoid:**
- "I work at the intersection of X, Y, and Z" — generic template
- "Passionate about" — empty credentialing
- "Pioneered" — use "created," "developed," "built"

**Personal anchor:** Connect the work to the person. The graphic design origin, the
visual culture roots, Half Moon Bay — not decoration, but the same mind that grounds
abstraction in physical reality.

### Correspondence (Recruiter Emails, Follow-ups)

**Posture:** Generous peer. Warm, direct, not salesy. Short paragraphs, no formality
theater. Sound like someone you'd want to work with, not someone performing
enthusiasm.

## Portfolio Quick-Check

Run this on all `/portfolio/` pages before finalizing:

- [ ] First sentence: concrete fact or reframe, not a value declaration
- [ ] Through-line: specific enough that only Kai could say it
- [ ] At least one physically grounded detail per page
- [ ] "I" for decisions, "we" / "my team" for execution — check each instance
- [ ] Each section closes on a strong claim, not a trailing metric
- [ ] No tricolons in adjacent sections
- [ ] Em dashes replaced with periods or colons unless no other punctuation serves
- [ ] Run voice-antipatterns.md check — especially the fatal pattern and hedging language

## Diagnostic Lenses (Most Useful for This Register)

- **Monteiro Lens** — Are you hedging? State the claim.
- **Malik Lens** — Where is the person? Is there a human anchor?
- **Gruber Lens** — Can this be shorter?

## Reference

- Portfolio source: `/Users/kai/Code/github.com/conragan/src/content/portfolio/`
- Existing case studies: `ai-mode.mdx`, `google-search.mdx`
- Voice feedback: `~/.claude/projects/-Users-kai-Code-github-com-conragan/memory/voice-*.md`
