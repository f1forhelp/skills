# Kling 4.0 Prompt Templates

Contents
1. Simple prompt
2. Standard four-block (Omni Reference / directed T2V)
3. Long-form production brief (15 sections)
4. Keyframe briefs (first frame, first+last, multiple keyframes)
5. Edit briefs
6. Creative recreation
7. Dialogue, voice and subtitle blocks
8. Reference-role phrase bank

Fill `<slots>`; delete sections that don't apply. Keep wording concrete (see SKILL.md Rule 1).

---

## 1. Simple prompt
```
<Subject with 2–3 visual specifics> <does one clear action> in <setting with concrete details>. <One camera move>, <light source and quality>. <Ambient sound / SFX>. No background music.
```

---

## 2. Standard four-block
```
[ASSET ROLES]
@Image1 defines <what>; preserve its <specific features>.
@Image2 defines <what>; preserve its <specific features>.
Reference the <camera path / action timing / pacing> of @Video1 only; do not take its <setting / people / style>.

[OVERALL]
<Duration>, <aspect ratio>. Setting and textures: <concrete details>. Visual style: <style with materials/grade>. Camera character: <handheld / locked-off / gimbal, lens feel>.

[TIMELINE]
0–<X>s: <what is visible> + <action> + <emotion>. Camera: <move>.
<X>–<Y>s: <action change>. Camera: <move>. <Extra detail>.
<Y>s–end: <closing action and final composition>. Hold on <final image>.

[AUDIO]
Dialogue: <speaker> says in <language/accent>, <tone/speed>: "<line>"
Ambience: <bed>. SFX: <synced sounds>. Music: <description, or "no background music">.
<No subtitles.>
```

---

## 3. Long-form production brief (15 sections)
Kling's own showcase prompts use these headings. Use for 15–30 s, multi-shot, ads, action, dialogue scenes.

```
1. SCENE CONTEXT: EXACTLY <N> <CHARACTERS/SUBJECTS> — NO DUPLICATES. <One-paragraph logline: who, where, what happens, duration, number of shots, pacing.>

2. ACTIVE REFERENCES: @<Asset> controls <identity/design/location details to preserve>. <Repeat per asset. State what each must NOT contribute.>

3. LOCATION MAP: <Fixed layout: what is screen-left/right/ahead. Direction of travel. Which side of the action axis the camera stays on.>

4. FIRST FRAME AND SPATIAL BLOCKING: <Exact opening state: positions, poses, what is already in motion. Start mid-action rather than on an empty beat.>

5. FORMAT MODE: <Total duration, aspect ratio, number of shots, cut type.>
SHOT 1 — 0.0–<t>s: <purpose>.
SHOT 2 — <t>–<t>s: <purpose>.
<Cuts are hard cuts / one continuous take. Name motivated wipes if any.>

6. OPTICS: <Per shot: focal length equivalent, field of view, framing, depth of field.>

7. CAMERA: <Operator type and behaviour per shot: handheld settle, tracking distance, push-in amount, shake intensity.>

8. ACTION TIMING:
<t>–<t>s: <precise action>.
<t>–<t>s: <precise action>.
<…every beat until the end…>

9. PHYSICS: <Weight, inertia, cloth/hair response, contact, how materials deform and recover.>

10. LIGHTING: <Single motivated key source and direction, fills/practicals, what highlights/shadows to protect, consistency across cuts.>

11. AUDIO: <Dialogue in quotes with voice description and emphasis; ambience; synced SFX; music or "SFX only, no music, no score"; mix priority.>

12. CHARACTER ACTING: <Intent, eyeline, how expression evolves, micro-behaviours. Optional INNER, UNSPOKEN: "<thought>".>

13. STYLE: <Genre/look, texture/grain, palette with ratios e.g. 60/30/10.>

14. QUALITY: <What must stay consistent: identity, anatomy counts, product geometry, readable text, no ghosting.>

15. POSITIVE CONSTRAINTS: <Exact counts and deadlines ("launches before 2 s"), required visibility, one-line list of what must not be added (subtitles, music, extra people). Optional: "<failure conditions> = failed shot.">
```

---

## 4. Keyframe briefs

### First frame
```
Use @Image1 as the first frame. <Describe what happens next, beat by beat.> Camera: <move>. <Audio.>
```

### First + last frame
```
Use @Image1 as the first frame (<what it shows>) and @Image2 as the last frame (<what it shows>). <Duration>. <Describe the process between them, with timed beats.> <Shot structure: one continuous take / N cuts.> The final frame matches @Image2 exactly.
```

### Multiple keyframes
Plan first:
| Time | Keyframe | What the viewer must see |
|---|---|---|
| 0s | @Image1 | <state> |
| <t>s | @Image2 | <state> |
| … | … | … |

```
Keyframes: @Image1 at 0s (<state>), @Image2 at <t>s (<state>), @Image3 at <t>s (<state>) … @ImageN at end (<state>).

0–<t>s (@Image1 → @Image2): <action and camera that carry us from state 1 to state 2>.
<t>–<t>s (@Image2 → @Image3): <transition>.
…
Continuity: <identity, outfit, product, lighting that must stay the same>. Change only <what changes between frames>.
Audio: <…>
```
Check: prompt order = keyframe order; each keyframe changes only what needs to change.

---

## 5. Edit briefs
```
Edit @Video1. <Change X to Y — be specific about which object/person, when, and how>. Keep everything else unchanged, including <camera movement, composition, lighting, timing, audio, duration, other subjects>.
```
Variants:
- Add: `Edit @Video1. At <moment>, add @Element1 <doing what, where>.`
- Replace characters: `Edit @Video1. Replace <first person> with @Image1 (<appearance description>); <second person> with @Image2 (<…>). Follow the original actions and camera timing.`
- Remove: `Edit @Video1 to remove <subject>. Keep everything else unchanged… Reconstruct the area behind them naturally.`
- Restyle: `Edit @Video1. Change only the visual style to <style>, matching @Image1. Preserve composition, shots, camera moves, actions, timing and sequence exactly. Do not change <clothing designs / props / scene elements>.`
- Dialogue swap: `Replace the line "<old>" with "<new>".`

---

## 6. Creative recreation
```
Replace the <subject/product> in @Video1 with the one in @Image1. Keep everything else unchanged, including background composition, camera movements, lighting, shadows, audio and duration. Match the original subject's position, scale, movement and trajectory.
```
Or borrowing structure only:
```
Borrow the <pacing / shot order / composition / camera path> of @Video1. Replace its <characters / product / setting> with @Image1 and @Image2. <New story beats on the same timing.>
```

---

## 7. Dialogue, voice and subtitles
```
<Speaker description> speaks in <language + accent>, <age-appropriate voice>, <tone>, <speed>: "<line in that language>" Emphasize "<word>". <Pause ~0.5 s.>
Each person has a distinct voice. Only one person speaks at a time. Lip movements sync to the spoken language.
```
Subtitles:
```
Burned-in <language> subtitles, bottom-centre inside title-safe, 10% above the lower edge, max two lines, <font/panel style>, stable position. Each appears and disappears with its line:
<t>–<t>s: "<TEXT>"
```
On-screen sign/logo:
```
A <sign/label> with the exact text `<TEXT>` is fixed <where>; it stays correctly spelled, undistorted and stable throughout.
```

---

## 8. Reference-role phrase bank
- Identity: `Reference the facial features, hairstyle and clothing of the person in @Image1; keep them strictly consistent.`
- Product: `@Image2 defines the product: preserve its shape, colour, materials, label and proportions.`
- Scene: `@Image3 defines the location: preserve its layout, furnishings and lighting.`
- Composition: `Match the composition of @Image1 exactly.`
- Action: `Reference the choreography and attack timing of @Video1.`
- Camera: `Reference the camera path and pacing of @Video1; replace the subject with @Image1 and the background with @Image2.`
- Storyboard: `Use @Image2 as the approved storyboard for shot order, framing, camera paths, screen direction and emotional progression. Render finished frames; do not reproduce sketch lines, grids, panel labels or notes.`
- Voice: `<Character> speaks with the voice of @Voice1.` (use the asset label the interface assigns)
- Scope limit: `Use @Video1 for timing only; do not inherit its setting, people or visual style.`
