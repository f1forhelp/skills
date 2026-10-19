#!/usr/bin/env bash
# Scaffold a clean episodic show blueprint folder structure and placeholder markdown files.
# Usage:
#   bash scaffold_show.sh [target_dir] [num_episodes] [scenes_per_episode] [show_title]
# Example:
#   bash scaffold_show.sh ./my-show 1 1 "My Show"

set -euo pipefail

TARGET_DIR="${1:-.}"
NUM_EPISODES="${2:-1}"
SCENES_PER_EP="${3:-1}"
SHOW_TITLE="${4:-Show}"

mkdir -p "$TARGET_DIR"/{characters,audio/voice,audio/sound,props,locations,weather}

write_if_missing() {
  local filepath="$1"
  shift
  if [ ! -f "$filepath" ]; then
    cat <<EOF > "$filepath"
$*
EOF
    echo "Created: $filepath"
  else
    echo "Skipped (already exists): $filepath"
  fi
}

# 1. AGENTS.md
if [ ! -f "$TARGET_DIR/AGENTS.md" ]; then
  cat <<EOF > "$TARGET_DIR/AGENTS.md"
# ${SHOW_TITLE} Project

An episodic show project. Read the relevant file below before writing any prompt or generating any shot.

## Reference files

| File | Covers |
|---|---|
| [STORY.md](STORY.md) | Overall story in brief: logline, tone, arc, episode list |
| \`episode/<N>_episode/EPISODE_<N>.md\` (e.g. [EPISODE_1.md](episode/1_episode/EPISODE_1.md)) | Episode overview and scene index |
| \`episode/<N>_episode/scenes/scene_<M>/SCENE_<M>.md\` | One self-sufficient scene (a single continuous camera angle): act, dialogue, references, prompt |
| [characters/CHARACTER.md](characters/CHARACTER.md) | Characters: role, personality, appearance, outfits, expressions |
| [audio/AUDIO.md](audio/AUDIO.md) | Audio assets: character voices (\`audio/voice/\`) and background/element sound effects (\`audio/sound/\`) |
| [props/PROPS.md](props/PROPS.md) | Props |
| [locations/LOCATIONS.md](locations/LOCATIONS.md) | Locations |
| [weather/WEATHER.md](weather/WEATHER.md) | Weather and lighting |

Each asset folder (\`characters/\`, \`audio/\`, \`props/\`, \`locations/\`, \`weather/\`) holds both its markdown documentation and its reference media files. Inside \`audio/\`, character voice samples live in \`audio/voice/\` and all other sounds (background ambience, element-specific SFX) live in \`audio/sound/\`.

## Episode Folder Structure

Every episode lives in \`episode/<N>_episode/\` and contains:

- \`EPISODE_<N>.md\` — Episode overview and scene index
- \`scenes/\` — Numbered sequentially across the episode (\`scene_1/\`, \`scene_2/\`, …). Each scene is a self-sufficient folder for **one continuous camera angle** (moving or locked-off, no cuts), containing:
  - \`SCENE_<M>.md\` — The scene's act, dialogue, reference table and generation prompt
  - \`keyframe/\` — Keyframe images for that scene, named clearly (e.g. \`scene_<M>_start.png\`, \`scene_<M>_end.png\`)
  - \`render/\` — Individual video renders for that scene
- \`render_temp/\` — Temporary / work-in-progress stitched episode videos assembled from scenes
- \`render_final/\` — The final stitched episode video assembled from the approved scene renders

## Rules

- **Keep docs normalized.** Each fact lives in exactly one file. To use a fact elsewhere, link to the file that owns it instead of restating it.
  - Character traits and looks → [characters/CHARACTER.md](characters/CHARACTER.md)
  - Voices (\`audio/voice/\`) and sounds/SFX (\`audio/sound/\`) → [audio/AUDIO.md](audio/AUDIO.md)
  - Objects → [props/PROPS.md](props/PROPS.md)
  - Places → [locations/LOCATIONS.md](locations/LOCATIONS.md)
  - Weather, light and color → [weather/WEATHER.md](weather/WEATHER.md)
  - Overall plot → [STORY.md](STORY.md), kept brief: one line per arc beat, no scene detail
  - Episode index → \`episode/<N>_episode/EPISODE_<N>.md\`
  - Individual scene act, dialogue and prompt → \`episode/<N>_episode/scenes/scene_<M>/SCENE_<M>.md\`
- **One camera angle per scene.** An episode consists of multiple scenes, and each scene covers a single continuous camera angle (static or moving camera, with no cuts). A new scene starts whenever the camera cuts to a new angle.
- **Keep asset docs neutral.** \`CHARACTER.md\`, \`AUDIO.md\`, \`PROPS.md\`, \`LOCATIONS.md\` and \`WEATHER.md\` describe only the asset. They contain no scene notes, story tie-ins or ready-made prompts. One exception: each extra (minor character) in \`characters/CHARACTER.md\` has an **Appears in** line linking the episode(s) it's used in.
- **Build prompts from the docs.** Compose each prompt from the owning files at generation time, using their wording. Don't invent new hair, outfit, prop or location details.
- **Use the reference assets.** Pass the matching image (and voice/sound, where applicable) as a reference whenever the tool allows it.
- **Add new material in one place.** Put a new asset in its folder (\`audio/voice/\` for character voices, \`audio/sound/\` for other sounds) and describe it in the matching \`.md\` file inside that folder. For a new category, create a new folder with its \`.md\` file and add a row to the table above. For a new episode, create \`episode/<N>_episode/\` with \`EPISODE_<N>.md\`, \`scenes/\` (each \`scene_<M>/\` containing \`SCENE_<M>.md\`, \`keyframe/\` and \`render/\`), \`render_temp/\` and \`render_final/\`, and add a row to the episode table in [STORY.md](STORY.md).
- **Generation costs credits.** Confirm the model, duration and resolution with the user before submitting any paid external generation job, and don't submit test runs.
- **Scene renders vs. episode stitched renders.**
  - Save each scene's keyframes in \`episode/<N>_episode/scenes/scene_<M>/keyframe/\` (\`scene_<M>_start.png\`, \`scene_<M>_end.png\`) and its generated video clips in \`episode/<N>_episode/scenes/scene_<M>/render/\`.
  - Use \`episode/<N>_episode/render_temp/\` and \`episode/<N>_episode/render_final/\` strictly for the stitched video joined across scenes (temporary stitched cuts in \`render_temp/\`, final stitched episode video in \`render_final/\`).
EOF
  echo "Created: $TARGET_DIR/AGENTS.md"
fi

# 2. STORY.md
if [ ! -f "$TARGET_DIR/STORY.md" ]; then
  cat <<EOF > "$TARGET_DIR/STORY.md"
# Story

> The overall story in brief. Scenes, settings and dialogue live in the episode files.

## Logline

*(Add logline)*

## Tone

*(Add tone and visual style)*

## Arc

1. **Beat 1:** *(Add arc beat)*

## Episodes

| Episode | File |
|---|---|
EOF
  for ((ep=1; ep<=NUM_EPISODES; ep++)); do
    echo "| ${ep} | [EPISODE_${ep}.md](episode/${ep}_episode/EPISODE_${ep}.md) |" >> "$TARGET_DIR/STORY.md"
  done
  echo "Created: $TARGET_DIR/STORY.md"
fi

# 3. Asset Placeholder Docs
write_if_missing "$TARGET_DIR/characters/CHARACTER.md" "# Characters

## <Character Name>

Reference: [character_<name>.png](character_<name>.png)

- **Role:** *(main lead / side character)*
- **Personality:** *(personality)*
- **Build:** *(build and posture)*
- **Face:** *(facial features)*
- **Hair:** *(hair style and color)*
- **Outfits:**
  - **A: Default:** *(outfit details)*
- **Expressions:** *(expressions)*"

write_if_missing "$TARGET_DIR/audio/AUDIO.md" "# Audio

Audio assets are organized into two subfolders inside \`audio/\`:

| Subfolder | Purpose |
|---|---|
| [\`voice/\`](voice/) | Character voice reference samples |
| [\`sound/\`](sound/) | Background ambience, environmental audio, and element-specific sound effects |

## Character voices (\`voice/\`)

| Character | File | Length | Notes |
|---|---|---|---|
| *(Add character voice files in [\`voice/\`](voice/) and list them here)* | — | — | — |

## Sound effects & ambience (\`sound/\`)

| Sound | File | Description |
|---|---|---|
| *(Add background or element-specific sound files in [\`sound/\`](sound/) and list them here)* | — | — |"

write_if_missing "$TARGET_DIR/props/PROPS.md" "# Props

## <Prop Name>

Reference: [props_<name>.png](props_<name>.png)

- *(Describe prop visual details)*"

write_if_missing "$TARGET_DIR/locations/LOCATIONS.md" "# Locations

## <Location Name>

References:
- [location_<name>.png](location_<name>.png): *(view description)*

*(Overview of the location.)* Areas:

- **<Area 1>:** *(layout and visual details)*"

write_if_missing "$TARGET_DIR/weather/WEATHER.md" "# Weather

## Weather 1: <Weather Name>

Reference: [weather_1.png](weather_1.png)

- **Condition:** *(sky/cloud condition)*
- **Time:** *(time of day)*
- **Feel:** *(temperature, wind, visibility)*
- **Sky:** *(sky colors and clouds)*
- **Lighting:** *(lighting details)*
- **Palette:** *(color palette)*"

# 4. Episodes & Scenes
for ((ep=1; ep<=NUM_EPISODES; ep++)); do
  EP_DIR="$TARGET_DIR/episode/${ep}_episode"
  mkdir -p "$EP_DIR"/{render_temp,render_final,scenes}

  EP_FILE="$EP_DIR/EPISODE_${ep}.md"
  if [ ! -f "$EP_FILE" ]; then
    cat <<EOF > "$EP_FILE"
# Episode ${ep}

> Part of the overall story in [STORY.md](../../STORY.md).

## Episode Folders

| Folder | Purpose |
|---|---|
| [\`scenes/\`](scenes/) | Self-sufficient single-camera scenes (\`scene_1/\` … \`scene_${SCENES_PER_EP}/\`), each containing its \`SCENE_<M>.md\` doc, [\`keyframe/\`](scenes/scene_1/keyframe/) folder and [\`render/\`](scenes/scene_1/render/) folder |
| [\`render_temp/\`](render_temp/) | Temporary / work-in-progress stitched videos joined from scenes |
| [\`render_final/\`](render_final/) | Final stitched episode video joined from the approved scene clips |

## Scene Rules

- **One camera angle per scene:** Each scene is a single continuous camera shot (locked-off or moving camera, with no cuts). A new scene starts only where the camera angle changes.
- **Sequential approval:** Each scene is approved before the next dependent scene is generated.

## Scenes

### Sequence 1: <Sequence Title>

**Where:** *(Location)* ([LOCATIONS.md](../../locations/LOCATIONS.md))
**Who:** *(Characters)* ([CHARACTER.md](../../characters/CHARACTER.md), [PROPS.md](../../props/PROPS.md))
**Weather:** *(Weather)* ([WEATHER.md](../../weather/WEATHER.md))

| Scene | Camera Angle | Length | What happens | Doc | Keyframes | Renders |
|---|---|---|---|---|---|---|
EOF
    for ((sc=1; sc<=SCENES_PER_EP; sc++)); do
      echo "| **Scene ${sc}** | *(Camera angle)* | *(Length)* | *(What happens)* | [SCENE_${sc}.md](scenes/scene_${sc}/SCENE_${sc}.md) | [\`keyframe/\`](scenes/scene_${sc}/keyframe/) | [\`render/\`](scenes/scene_${sc}/render/) |" >> "$EP_FILE"
    done
    echo "Created: $EP_FILE"
  fi

  for ((sc=1; sc<=SCENES_PER_EP; sc++)); do
    SC_DIR="$EP_DIR/scenes/scene_${sc}"
    mkdir -p "$SC_DIR"/{keyframe,render}
    SC_FILE="$SC_DIR/SCENE_${sc}.md"
    if [ ! -f "$SC_FILE" ]; then
      cat <<EOF > "$SC_FILE"
# Episode ${ep} — Scene ${sc}: <Scene Title>

> Part of [Episode ${ep}](../../EPISODE_${ep}.md). Keyframes go in [\`keyframe/\`](keyframe/) and renders go in [\`render/\`](render/).

## Act

**Where:** *(Location)* ([LOCATIONS.md](../../../../locations/LOCATIONS.md))
**Who:** *(Characters)* ([CHARACTER.md](../../../../characters/CHARACTER.md), [PROPS.md](../../../../props/PROPS.md), [AUDIO.md](../../../../audio/AUDIO.md))
**Weather:** *(Weather)* ([WEATHER.md](../../../../weather/WEATHER.md))
**Camera:** *(Camera position, lens, movement — one continuous shot, no cuts)*
**Length:** *(Length)*

1. **Beat 1:** *(Action description)*

**Dialogue**

> **<Character>**: *(Line)*

## References

| Tag | File | Role |
|---|---|---|
| *(Tag)* | *(Relative link to asset file)* | *(Role in scene)* |

**Notes**

- *(Scene continuity and spatial notes)*

## Prompt

\`\`\`
*(Add generation prompt here)*
\`\`\`
EOF
      echo "Created: $SC_FILE"
    fi
  done
done

echo "Done! Show blueprint scaffolded at: $TARGET_DIR"
