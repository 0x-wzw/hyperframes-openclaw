# HyperFrames — OpenClaw Agent Skill

> Write HTML. Render video. Built for agents.

An [OpenClaw](https://github.com/openclaw/openclaw) agent skill wrapping [HyperFrames](https://github.com/heygen-com/hyperframes) — the open-source HTML-to-video framework with first-class agent support.

## What It Does

Turns structured HTML compositions into MP4 videos. Designed for agent-driven pipelines:

- **Intelligence briefings** → animated data summaries
- **Explainer videos** → papers, repos, concepts in 15-60s clips  
- **Social content** → TikTok/Reels verticals with captions
- **Data visualizations** → animated charts, counters, comparisons

## Why This Exists

OpenClaw agents generate a lot of text. Sometimes you need video — for Moltbook posts, intelligence pipeline summaries, or social content. HyperFrames' HTML-native approach means agents already speak the format. No proprietary DSL, no GUI clicking.

## Quick Start

```bash
# Install as OpenClaw skill
npx skills add 0x-wzw/hyperframes-openclaw

# Or clone directly
git clone https://github.com/0x-wzw/hyperframes-openclaw.git ~/.openclaw/skills/hyperframes-openclaw

# Create a composition
npx hyperframes init my-video --non-interactive
cd my-video
# Edit index.html with your composition
npx hyperframes render --non-interactive
```

## Composition Example

```html
<div id="root" data-composition-id="main" data-start="0" 
     data-duration="15" data-width="1920" data-height="1080">
  
  <div id="title" class="clip" data-start="0" data-duration="5" 
       data-track-index="0" style="font-size:72px;color:#fff;padding:40px">
    Your Title Here
  </div>
</div>

<script>
  window.__timelines = window.__timelines || {};
  const tl = gsap.timeline({ paused: true });
  tl.from("#title", { opacity: 0, y: -50, duration: 1 }, 0);
  window.__timelines["main"] = tl;
</script>
```

## Visual Styles

8 named presets: Swiss Pulse, Velvet Standard, Deconstructed, Maximalist Type, Data Drift, Soft Signal, Folk Frequency, Shadow Cut. See `references/visual-styles.md`.

## Agent Workflow

1. **Classify** → data viz, explainer, or social clip?
2. **Choose style** → pick from visual presets
3. **Draft** → write HTML with data attributes + GSAP
4. **Lint** → `npx hyperframes lint`
5. **Render** → `npx hyperframes render --non-interactive`
6. **Deliver** → send MP4 via Telegram/Discord

## Requirements

- Node.js >= 22
- FFmpeg
- npx

## Performance

- 30-60s render time for 15s clip at 1080p
- ~500MB-1GB memory per render (Puppeteer/Chrome)
- ~100MB Chrome download (first run, cached)

## Skill Structure

```
hyperframes-openclaw/
├── SKILL.md                    # Agent skill definition
├── README.md                   # This file
├── scripts/
│   ├── render.sh               # Render wrapper
│   └── quick-compose.sh        # Quick scaffolding
└── references/
    ├── patterns.md              # Composition patterns
    ├── visual-styles.md         # 8 named visual presets
    ├── data-in-motion.md        # Data viz rules for video
    ├── house-style.md           # Typography and color guidelines
    ├── gsap.md                  # GSAP animation reference
    ├── cli.md                   # Full CLI reference
    ├── registry.md              # Registry block catalog
    ├── website-to-hyperframes.md
    └── palettes/
```

## Credits

- [HyperFrames](https://github.com/heygen-com/hyperframes) by HeyGen — Apache 2.0
- Skill wrapper by [october10d](https://www.moltbook.com/u/october10d) for OpenClaw

## License

MIT