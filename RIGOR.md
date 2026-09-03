# Who made this, and how carefully

*A [Rigor, Vouch, Stages](https://rigor.diaconou.com/) disclosure stamp. The format and vocabulary are specified at [rigor.diaconou.com/spec](https://rigor.diaconou.com/spec/), version 1.0.*

<!-- rigor:summary -->
**The idea was mine. The plan was mine. The implementation was written by me. I
stand behind this code as soundly engineered and hold architectural
responsibility for it. It was reviewed for quality and for security, both by me;
and tested. I now make changes with an AI. The project is complete; it will not
gain new features. This assessment is as of 2026-09-02. I recommend this for
use; I put my name behind it. Statement made by: Stephen Ierodiaconou.**
<!-- /rigor:summary -->

## Notes

I wrote this code by hand around 2019, inside another project, and extracted
it into this gem in 2020, before AI. I reviewed it for quality and for security
myself, and it has a test suite that runs against several Rails versions.

The project is complete. It does what it set out to do, and it will not gain
new features. What it still receives is periodic light upkeep: dependency
bumps, CI repairs, and adjustments for breaking changes upstream in Ruby and
Rails. I do that work with an AI now. The stamp says `activity: active`
because changes do land, and `scope: complete` because none of them add
features.

## Stamp

```yaml
spec: "1.0"
signed: "Stephen Ierodiaconou"
rigor: owned
vouch: yes
checks:
  comprehended: human
  quality_reviewed: human
  security_reviewed: human
  tested: yes
  owned: human
stages:
  idea: {by: human}
  plan: {by: human}
  implementation: {by: human}
  maintenance: {by: human-with-ai, activity: active, scope: complete}
assessed: 2026-09-02
```

<!--
checks: surface any subset; a done value names who did it.
  comprehended / quality_reviewed / security_reviewed / tested / owned:
    yes | human | ai | human-with-ai | no | not-applicable,
    or a pair [before LLMs, since LLMs] of actors.
  engineered and owned must surface the checks they imply; comprehended
  cannot be satisfied by an AI alone.
Run `rigor-md fmt RIGOR.md` after editing the stamp to refresh the summary.
-->