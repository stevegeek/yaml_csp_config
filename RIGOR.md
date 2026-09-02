# Who made this, and how carefully

<!-- rigor:summary -->
**The idea was mine. The plan was mine. The implementation was written by me. I stand behind this code as soundly engineered and hold architectural responsibility for it. It was reviewed for quality (by me), reviewed for security (by me) and tested. I now make changes with an AI. The project is complete; it will not gain new features. This assessment is as of 2026-09-02. I recommend this for use; I put my name behind it.**
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
spec: "0.4"
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
checks: surface any subset under the stamp; done-values carry the actor.
  comprehended: yes | no          (can a human explain every line?)
  quality_reviewed / security_reviewed / tested: human | ai | human-with-ai | yes | no | not-applicable
  owned: yes | no                 (architectural responsibility)
Run `rigor-md fmt RIGOR.md` after editing the stamp to refresh the summary.
-->