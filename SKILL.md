---
name: hyperframes-openclaw
description: Create, preview, and render HTML-based video compositions using HyperFrames. Use when generating explainer videos, intelligence pipeline summaries, animated data visualizations, social clips, or any structured video output. Designed for agent-driven workflows — non-interactive CLI, deterministic rendering, HTML-native compositions with GSAP animation.
version: 0.1.0
author: october10d
tags: [video, html, gsap, animation, rendering, hyperframes, agent-first]
requires:
  - node >= 22
  - ffmpeg
  - npx
---

# HyperFrames — OpenClaw Agent Skill

Write HTML. Render video. Built for agents.

This skill wraps [HyperFrames](https://github.com/heygen-com/hyperframes) (Apache 2.0) for OpenClaw agent workflows. It provides deterministic HTML-to-video rendering with GSAP animations, designed for non-interactive agent pipelines.

## When to Use

- **Intelligence pipeline summaries** — animate data into video briefings
- **Explainer videos** — turn papers, repos, or concepts into 15-60s clips
- **Social content** — TikTok/Reels-style vertical videos with captions
- **Data visualizations** — animated charts, counters, comparisons
- **Product intros** — title cards, feature reveals, transitions

## Quick Start

```bash
# Initialize a composition project
npx hyperframes init my-video --non-interactive
cd my-video

# Edit index.html (see Composition Guide below)
# Then render:
npx hyperframes render
```

Or use the helper script:

```bash
./scripts/quick-compose.sh "intel-briefing" 15
# Edit the generated index.html, then render
```

## Composition Guide

### Structure

Every composition is an HTML file with `data-*` attributes for timing:

```html
<div id="root"
  data-composition-id="main"
  data-start="0"
  data-duration="15"
  data-width="1920"
  data-height="1080">

  <div id="title" class="clip"
    data-start="0" data-duration="5" data-track-index="0">
    Title Card
  </div>

  <div id="detail" class="clip"
    data-start="3" data-duration="7" data-track-index="1">
    Detail Section
  </div>
</div>
```

### Key Attributes

| Attribute | Purpose | Example |
|-----------|---------|---------|
| `data-composition-id` | Unique ID for the composition | `"main"` |
| `data-start` | Start time in seconds | `"3"` |
| `data-duration` | Duration in seconds | `"5"` |
| `data-track-index` | Layer order (0=bottom) | `"1"` |
| `data-width` / `data-height` | Resolution | `"1920"` / `"1080"` |

### Animation (GSAP)

Add a `<script>` block with a GSAP timeline:

```html
<script>
  window.__timelines = window.__timelines || {};
  const tl = gsap.timeline({ paused: true });
  tl.from("#title", { opacity: 0, y: -50, duration: 1 }, 0);
  tl.from("#detail", { opacity: 0, x: 100, duration: 0.8 }, 3);
  window.__timelines["main"] = tl;
</script>
```

**Timeline key**: The timeline name MUST match `data-composition-id`.

### Visual Styles

Choose a style before composing. See `references/visual-styles.md` for 8 named presets:

| Style | Mood | Best For |
|-------|------|----------|
| Swiss Pulse | Clinical, precise | SaaS, data, dev tools |
| Velvet Standard | Premium, timeless | Luxury, enterprise |
| Deconstructed | Industrial, raw | Tech launches, security |
| Maximalist Type | Loud, kinetic | Big announcements |
| Data Drift | Futuristic | AI, ML, cutting-edge |
| Soft Signal | Intimate, warm | Wellness, personal stories |
| Folk Frequency | Cultural, vivid | Consumer apps, communities |
| Shadow Cut | Dark, cinematic | Dramatic reveals |

### Data Visualization Rules

From `references/data-in-motion.md`:
- **No pie charts** — hard to compare in motion
- **No multi-axis charts** — viewer can't study in 3 seconds
- **No 6-panel dashboards** — 2-3 metrics max per frame
- **No gridlines/tick marks** — visual noise
- **Build with GSAP + CSS** — not D3 or Chart.js
- **Numbers need visual weight** — pair with fill bars, progress rings, color shifts

## CLI Commands

```bash
npx hyperframes init <name>           # Scaffold project
npx hyperframes add <block>           # Install registry block
npx hyperframes lint                   # Validate composition
npx hyperframes preview                # Browser preview (live reload)
npx hyperframes render                 # Render to MP4
npx hyperframes render --non-interactive  # No prompts (CI/agents)
npx hyperframes transcribe <audio>     # Transcribe audio file
npx hyperframes tts <text>             # Text-to-speech
npx hyperframes doctor                 # Check environment
```

See `references/cli.md` for full CLI reference.

## Registry Blocks

50+ pre-built blocks available:

```bash
npx hyperframes add data-chart          # animated chart
npx hyperframes add flash-through-white # shader transition
npx hyperframes add instagram-follow    # social overlay
```

See `references/registry.md` for full catalog.

## Agent Workflow

1. **Classify** — Is this a data viz, explainer, or social clip?
2. **Choose style** — Pick from visual-styles.md based on mood
3. **Draft composition** — Write HTML with data attributes and GSAP timeline
4. **Lint** — `npx hyperframes lint`
5. **Render** — `npx hyperframes render --non-interactive`
6. **Deliver** — Send MP4 via Telegram/Discord

### Intelligence Pipeline Integration

For daily intel summaries, create compositions programmatically:

```python
# Pseudocode for generating compositions from intel data
def generate_intel_video(intel_data):
    html = compose_intel_html(intel_data)  # Your template logic
    write("index.html", html)
    run("npx hyperframes render --non-interactive")
    return latest_render_path()
```

## Performance Notes

- **Rendering** is Puppeteer-based: 30-60s for a 15s clip at 1080p
- **Memory**: ~500MB-1GB per render (Chrome headless)
- **Disk**: ~100MB for Chrome download (first run only, cached)
- **Resolution**: 1920×1080 default; use 1080×1920 for vertical (9:16)

## Files

```
hyperframes-openclaw/
├── SKILL.md                    # This file
├── README.md                   # Repo readme
├── scripts/
│   ├── render.sh               # Render wrapper
│   └── quick-compose.sh        # Quick scaffolding
└── references/
    ├── patterns.md              # Composition patterns (PiP, splits, etc.)
    ├── visual-styles.md         # 8 named visual presets
    ├── data-in-motion.md        # Data viz rules for video
    ├── house-style.md           # Typography and color guidelines
    ├── gsap.md                  # GSAP animation reference
    ├── cli.md                   # Full CLI reference
    ├── registry.md              # Registry block catalog
    ├── website-to-hyperframes.md # Website capture workflow
    └── palettes/                # Color palette files
```

## License

This skill wraps HyperFrames (Apache 2.0) by HeyGen. The skill itself is MIT licensed.