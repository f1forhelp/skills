---
name: episodic-show-blueprint
description: >-
  Scaffold the initial folder structure and placeholder markdown documentation
  blueprint for any episode-based show (drama, K-drama, cartoon, anime, web series,
  etc.). Used once at the start of a show's lifecycle to set up the project skeleton
  (AGENTS.md, STORY.md, asset folders/docs, and episode/scene folders/docs) without
  any video/image model-specific logic.
---

# Episodic Show Blueprint Initializer

Use this skill **once at the beginning of a show's lifecycle** to create the directory tree and placeholder markdown files for any episode-based series (drama, cartoon, anime, anthology, etc.).

This skill is strictly a **project scaffolder**. It does **not** contain rules or logic for how any video, image, or audio generation model works—prompting and generation workflows are handled separately after the project structure is initialized.

---

## Folder & File Blueprint

```text
<show-root>/
├── AGENTS.md                                  # Project index, folder conventions, and normalization rules
├── STORY.md                                  # Placeholder for logline, tone, arc beats, and episode table
├── characters/
│   └── CHARACTER.md                          # Placeholder for character descriptions and reference links
├── audio/
│   ├── AUDIO.md                              # Placeholder index for character voices and sound effects
│   ├── voice/                                # Folder for character voice files
│   └── sound/                                # Folder for background ambience and SFX files
├── props/
│   └── PROPS.md                              # Placeholder for prop descriptions and reference links
├── locations/
│   └── LOCATIONS.md                          # Placeholder for location descriptions and reference links
├── weather/
│   └── WEATHER.md                            # Placeholder for weather and lighting descriptions
└── episode/
    └── 1_episode/
        ├── EPISODE_1.md                      # Placeholder for Episode 1 overview and scene table
        ├── render_temp/                      # Folder for work-in-progress stitched episode cuts
        ├── render_final/                     # Folder for final stitched episode video
        └── scenes/
            └── scene_1/
                ├── SCENE_1.md                # Placeholder for Scene 1 act, dialogue, references, and prompt
                ├── keyframe/                 # Folder for Scene 1 keyframe images
                └── render/                   # Folder for Scene 1 video renders
```

---

## Core Blueprint Conventions

1. **Normalized Structure:** Each piece of information has one dedicated file (`STORY.md`, `characters/CHARACTER.md`, `audio/AUDIO.md`, `props/PROPS.md`, `locations/LOCATIONS.md`, `weather/WEATHER.md`, `episode/<N>_episode/EPISODE_<N>.md`, `episode/<N>_episode/scenes/scene_<M>/SCENE_<M>.md`). Files link to one another using relative markdown paths rather than duplicating facts.
2. **One Camera Angle Per Scene:** Each `scene_<M>/` folder inside `episode/<N>_episode/scenes/` represents a single continuous camera angle (no cuts). A new scene folder is used whenever the camera angle changes.
3. **Separated Scene vs. Episode Renders:**
   - Individual scene keyframes live in `episode/<N>_episode/scenes/scene_<M>/keyframe/`.
   - Individual scene renders live in `episode/<N>_episode/scenes/scene_<M>/render/`.
   - Stitched episode cuts live in `episode/<N>_episode/render_temp/` (WIP) and `episode/<N>_episode/render_final/` (final).

---

## How to Run

### Option A: Run the Scaffolding Script (Recommended)
If shell execution is available, run [`scripts/scaffold_show.sh`](./scripts/scaffold_show.sh):

```bash
bash <path-to-skill>/scripts/scaffold_show.sh "<target-project-dir>" [num_episodes] [scenes_per_episode] ["Show Title"]
```

- `target-project-dir` (default: `.`): Path where the show blueprint will be created.
- `num_episodes` (default: `1`): Number of initial `episode/<N>_episode/` folders to scaffold.
- `scenes_per_episode` (default: `1`): Number of initial `scenes/scene_<M>/` folders to scaffold per episode.
- `Show Title` (default: `"Show"`): Title used in the `AGENTS.md` heading.

### Option B: Create Folders and Placeholder Files Directly
If running in an environment without bash access, create the directory tree shown above and write each placeholder `.md` file using the exact templates in [`references/templates.md`](./references/templates.md).

---

## Verification

After scaffolding, verify that:
- All asset directories (`characters/`, `audio/voice/`, `audio/sound/`, `props/`, `locations/`, `weather/`) and their placeholder `.md` files exist.
- `AGENTS.md` and `STORY.md` exist at the project root.
- Each scaffolded episode (`episode/<N>_episode/`) contains `EPISODE_<N>.md`, `render_temp/`, `render_final/`, and `scenes/scene_<M>/` (with `SCENE_<M>.md`, `keyframe/`, and `render/`).
