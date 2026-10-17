---
name: kling-4-prompt
description: Write, structure and fix prompts for Kling 4.0 and Kling 4.0 Flash video generation, following Kling's official 4.0 user guide. Covers text-to-video, Omni Reference (@Image/@Video/@Element roles), first/last frames and up to 10 keyframes, 30-second multi-shot timelines, video editing ("Edit @Video1"), creative recreation of a reference video, dialogue in any supported language or accent, burned-in subtitles and on-screen text, and stylized looks. Use this skill whenever the user mentions Kling, Kling 4, Kling 4.0, Kling Flash or kling.ai and wants a video prompt written, expanded, converted, translated or debugged, even if they just describe a scene ("make a Kling prompt where…", "turn this idea into a 15s ad for Kling", "my Kling video keeps adding music / the face drifts / the camera ignores me"). Also use it to convert prompts written for Kling 3.0, Seedance, Veo, Sora or other video models into Kling 4.0 format.
---

# Kling 4.0 Prompt Writer

Turn a scene idea, a set of assets, or a broken prompt into a copy-ready Kling 4.0 prompt that follows how Kling's own documentation says the model reads instructions.

Kling 4.0 is a multimodal video model: it reads text plus up to 15 reference assets, generates 3–30 s clips with stereo audio and lip sync, and splits long clips into multiple shots by default. The prompt is a director's brief, not a keyword list. Most of what goes wrong in Kling comes from four things: vague abstract wording, unassigned references, timelines that contradict the inputs, and negative instructions. This skill exists to prevent those.

Hard specs (durations, asset limits, resolutions, languages) live in `references/specs.md`. Read it when the user's request touches limits — e.g. more than a handful of assets, clips over 15 s, 21:9, 4K/HDR, or an unusual language.

## Workflow

### 1. Identify the mode

Pick one before writing anything, because each mode uses different phrasing and the two entry points cannot be mixed in one generation.

| Mode | Use when | Entry point | Key phrasing |
|---|---|---|---|
| Simple text-to-video | Exploring an idea, no assets | Omni Reference | One or two plain sentences; model expands it |
| Directed text-to-video | Specific story, timing, camera | Omni Reference | Full timeline structure |
| Omni Reference | Images/videos/elements/voices supplied | Omni Reference | `@Image1 defines…; preserve…` |
| Keyframes | Exact frames must appear at set moments | Keyframes (images only, no other references) | `Use @Image1 as the first frame…` |
| Video edit | Change part of an existing clip | Omni Reference | `Edit @Video1. Change X to Y. Keep everything else unchanged.` |
| Creative recreation | Borrow a clip's pacing/shots, swap content | Omni Reference | `Replace the subject in @Video1 with @Image1…` |

If the user needs both pixel-exact keyframes *and* character/product references, explain they can't be combined in one task and suggest either (a) Omni Reference with the "keyframe" images used as composition/first-frame references, or (b) the Keyframes entry with identity carried by the keyframe images themselves.

### 2. Gather only what's missing

Infer as much as possible from the request. Ask at most one or two questions, and only when the answer changes the prompt materially. Things worth asking if unknown: duration, aspect ratio, which uploaded asset is which, whether there's dialogue (and in what language), whether music is wanted. If the user wants speed, make sensible assumptions and list them under the prompt.

Defaults when unstated: 10 s, Auto aspect ratio (or 16:9 for cinematic, 9:16 for social/UGC), realistic live-action, ambient sound + SFX, no music, no subtitles.

### 3. Write the prompt using the core rules

**Rule 1 — Describe what the camera sees, never abstract labels.** The model has to guess at words like "premium", "cozy", "cinematic feel", "middle-class". Replace each with the concrete visual evidence of it.
- "luxurious" → "side backlight rims the bottle's edges, background falls to soft blur, fine matte grain on the glass"
- "old-fashioned" → "yellowed wallpaper, chipped furniture corners, warm tungsten bulbs"
- "a busy office" → "rows of monitors, a ringing desk phone, two people talking over a cubicle wall, coffee cups beside keyboards"

**Rule 2 — Phrase constraints positively.** Kling's guide warns that negative instructions raise the error rate. Instead of "don't show her face", write "she is seen in profile". Instead of "no extra people", write "exactly one woman is visible throughout".
The only two negatives worth writing by default are **"no subtitles"** and **"no background music"**, because the model tends to add both unless told otherwise. Add them whenever the user doesn't want them. Two other narrow exceptions are allowed: excluding photorealism when asking for an animation/stylized look, and listing artifacts a storyboard reference must not carry over (grids, sketch lines, annotations).

**Rule 3 — Give every asset a job.** Assets are auto-numbered by upload order (@Image1, @Image2, @Video1, @Element1…). Unassigned assets get guessed at. For each one state what it defines, what to preserve, and — when assets overlap — what *not* to take from it.
- `@Image1 defines the kitchen: preserve its layout, cabinets and window light.`
- `@Image2 defines the chef: preserve her face, hair and white jacket.`
- `@Video1 is the reference for camera path and cut timing only; do not take its setting or people.`
Keep each character/product description identical every time it's mentioned.

**Rule 4 — Write along a timeline.** For anything over ~5 s, break the action into timed beats (`0–4s`, `4–9s`…) or numbered shots with explicit durations. Each beat: what's visible, the action, the emotion, the camera. Every beat should contain an observable change — a 30 s clip with one action drags. If keyframes are used, the prompt's beats must follow the keyframe order exactly and describe the *transitions between* keyframes, not repeat what the images already show.

**Rule 5 — State counts and continuity explicitly.** Open longer prompts with the exact number of characters ("EXACTLY 2 CHARACTERS — NO DUPLICATES"). Pin screen direction and spatial layout ("harbour stays screen-left; travel always runs left to right"). Repeat identity anchors (outfit, distinguishing details) so they survive cuts.

**Rule 6 — Write audio as part of the scene.** Dialogue goes inside quotation marks, written in the language it should be spoken in. Describe the speaker's age, tone, speed and emotion, and which words to stress. Layer ambience, SFX and music separately, and state the mix priority ("footsteps and breathing louder than the score"). One speaker at a time unless overlap is intended.

**Rule 7 — Match length to need.** Up to 8,000 tokens is allowed, but length is not quality. A one-line idea is a valid prompt when the user is exploring — Kling will fill in story, blocking and camera. When the description is already precise, Kling follows it without adding its own interpretation, so detailed prompts are for when the user knows what they want.

### 4. Choose the structure

Pick the lightest structure that carries the request. Full templates with fill-in slots are in `references/templates.md` — read it before writing anything beyond a simple prompt.

- **Simple** (exploration, ≤10 s, no assets): 1–3 sentences, subject + action + setting + camera + light + sound.
- **Standard four-block** (most requests): Asset roles → Overall settings → Timeline → Audio.
- **Long-form production brief** (15–30 s, multi-shot, ads, action, dialogue scenes, anything where continuity matters): the 15-section format Kling uses in its own showcase prompts — Scene context, Active references, Location map, First frame & blocking, Format mode, Optics, Camera, Action timing, Physics, Lighting, Audio, Character acting, Style, Quality, Positive constraints.
- **Keyframe brief**: frame assignments → transitions per segment → camera/continuity → audio.
- **Edit brief**: `Edit @Video1` + precise change + explicit preservation list.

### 5. Deliver

Output in this order:

1. **Settings** — one line: mode/entry point, duration, aspect ratio, resolution suggestion, asset upload order (so @numbers line up).
2. **The prompt** — in a single code block so it copies cleanly. Write it in English unless the user asks otherwise; dialogue stays in its spoken language.
3. **Assumptions** — a short list only if you assumed anything material.
4. **Iteration tip** — optional, one line: what to change first if the result misses.

Don't pad with explanations of the rules unless asked. If the user supplies a prompt to fix, show the corrected prompt and a brief list of what changed and why.

## Mode-specific notes

**Keyframes.** Kling 4.0 accepts a first frame, a last frame, both, and middle frames at any timestamp (up to 10). Plan them by asking "what must the viewer see at this moment?" — if nothing important changes, it doesn't need a keyframe. Common failures Kling itself lists: too many keyframes, one keyframe that changes everything at once (character + location + lighting + style), keyframes that contradict references, and a prompt timeline in a different order from the keyframes. The Keyframes entry accepts images only; aspect ratio follows the first keyframe.

**Video editing.** Always write `Edit @Video1` — "Reference @Video1" may be read as "make a new video inspired by this". Name exactly what changes, then add an explicit preservation line: `Keep everything else unchanged, including …` and list camera movement, timing, lighting, audio, composition as relevant. For style changes, say the subject's actions/trajectory must be preserved frame by frame and which parts of the scene must *not* be restyled.

**Creative recreation.** Say what to borrow (pacing, shot order, composition, camera path, presentation style) and what to replace (subject, product, setting). Works best when the reference clip's pacing and shot structure resemble the target content — warn the user if they don't.

**Storyboards as references.** Tell Kling to treat the storyboard as the approved shot order, framing, camera paths and emotional progression, to render finished frames, and not to reproduce the storyboard itself (sketch lines, grids, panel labels, notes).

**Subtitles / on-screen text.** Kling 4.0 renders multilingual text, logos and emoji stably. For subtitles specify position (e.g. bottom-centre, 10% above the lower edge, inside title-safe), line limit, panel/font styling, and exact timestamps synced to each spoken line. For signs/logos give the exact text in backticks or quotes and say it must stay correctly spelled and stable.

**Styles.** For non-photoreal looks (animation, felt, clay, pixel art, anime), describe materials, lighting and motion character (e.g. "12 fps stepped stop-motion"), and exclude photorealism so styles don't blend.

**Kling 4.0 Flash.** Faster and cheaper; good for drafts and high-volume work. Keep prompts tighter and don't rely on multiple keyframes there.

## Fixing common problems

| Symptom | Likely cause | Fix |
|---|---|---|
| Unwanted music or subtitles | Model defaults | Add "no background music" / "no subtitles" (or "SFX only, no music, no score") |
| Face/product drifts between shots | Reference roles unclear or descriptions vary | Assign identity to one asset; repeat the same short description each shot; add quality line about consistency |
| Duplicate characters | Count not stated | Open with "EXACTLY N CHARACTERS — NO DUPLICATES" and positive count constraint at the end |
| Camera ignores direction | Vague or conflicting camera words | One concrete move per beat ("slow push-in", "locked-off wide", "lateral track left"); delete contradictory terms |
| Events happen in the wrong order | No timeline, or timeline contradicts keyframes | Add timestamped beats; align with keyframe order |
| Edit changed too much | No preservation list, or "Reference" instead of "Edit" | Use `Edit @Video1` + "Keep everything else unchanged, including …" |
| Animation looks half-real | Style not exclusive | Describe materials + add photorealism exclusion |
| Slow, boring 30 s clip | One action stretched out | Add beats, cuts or a turn every 4–8 s |
| Wrong language/accent | Dialogue not in target language | Write the line in that language in quotes; name the accent |
| Over-detailed prompt behaving oddly | Conflicting instructions buried in length | Trim to essentials; check every section agrees on counts, positions, order |

## Converting from other models

From Kling 3.0: 3.0 had start/end frames only and shorter clips, so the text carried the middle of the shot. In 4.0, move mid-clip states into keyframes or timed beats, extend to the real target duration, and assign roles to every reference. From Seedance/Veo/Sora-style prompts: convert reference tags to Kling's `@Image1`/`@Video1` numbering by upload order, strip negative-prompt lists down to the two default negatives, and rewrite adjective stacks as visual evidence.

## Reference files

- `references/specs.md` — Kling 4.0 limits and parameters (durations, asset counts/sizes, resolutions, aspect ratios, languages/accents). Read when limits matter.
- `references/templates.md` — fill-in templates for every structure above. Read before writing any non-simple prompt.
- `references/examples.md` — worked example prompts (original, written for this skill) for each mode. Read when you want a model of tone and density.

Specs reflect Kling's official Kling 4.0 User Guide (Oct 2026) and the Kling 4.0 Multiple Keyframes blog post. Features marked "coming soon" there (10-bit HDR, 2-minute extension) may not be live; check the interface if the user depends on them.
