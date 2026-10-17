# Kling 4.0 Specs and Limits

Source: Kling 4.0 User Guide (kling.ai/quickstart/kling-4-model-user-guide, Oct 2026) and Kling 4.0 Multiple Keyframes blog (Sep 2026). Product interface is authoritative if anything differs.

## Generation
| Item | Kling 4.0 |
|---|---|
| Modes | Text-to-video, image-to-video, first frame, first + last frame, multiple keyframes (up to 10), Omni Reference, video editing, creative recreation |
| Duration | 3–30 s, 1 s steps, default 10 s |
| Multi-shot | On by default — model splits shots and pacing from content |
| Resolution | 720p / 1080p / 4K |
| Dynamic range | 10-bit HDR at 1080p and 4K (listed as coming soon at launch) |
| Aspect ratio | 21:9 / 16:9 / 1:1 / 9:16 / Auto (default Auto). In Keyframes entry with images, follows the first keyframe |
| Audio | Two-channel stereo, lip sync |
| Prompt length | Up to 8,000 tokens |
| Video extension | Multiple extensions up to 2 min (coming soon at launch) |
| Flash variant | Kling 4.0 Flash — faster, cheaper, for drafts/high volume |

## Entry points (cannot be combined in one task)
| | Omni Reference (default) | Keyframes |
|---|---|---|
| Best for | Assets to reference, or just a concept | Predefined moments that must appear precisely |
| Controls | Appearance, style, action, camera | Placement of key moments on the timeline |
| Uploads | Images, videos, voice profiles, elements | Images only |

## Omni Reference input limits
| Input | Limit |
|---|---|
| Images | ≤10 total, ≤30 MB each, aspect 2:5–5:2 |
| Videos | ≤5, 3–30 s each, ≤30 s combined, ≤300 MB each, aspect 2:5–5:2 |
| Voice profiles | ≤3 per task; build from 5–30 s audio, ≤50 MB |
| Elements | ≤7, including ≤3 video elements (source footage 3–8 s) |
| Combined | ≤15 assets total |

Reference videos, videos being edited, and video elements share one video quota: 5 clips / 30 s combined.

## Video editing
Up to 5 clips including 1 primary video; each 3–30 s; ≤30 s total.

## Keyframes entry
≤10 images, ≤30 MB each, aspect 2:5–5:2. Supports first frame, last frame, first+last, and middle frames at any position. No other reference assets.

## Languages
Spoken: Chinese, English, Japanese, Korean, Spanish, Portuguese, German, French, Hindi (plus others).
Chinese dialects/accents: Sichuanese, Cantonese, Beijing, Northeastern, Taiwanese Mandarin.
English accents: American, British, Indian.
On-screen text: the same languages plus emoji and logos, stable through camera moves and cuts.

## Styles named by Kling
Cinematic, retro DV, animation, felt, fantasy, pixel art, cyberpunk, clay/stop-motion (shown in examples).
