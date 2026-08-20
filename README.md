# 2D Shaders & Particles Pack for Godot

A lightweight collection of 2D shaders, particle presets, and showcase scenes ready to drop directly into your Godot project.

---

## 📦 What's Included

### 🎨 Shaders (`res://Shaders/`)
* **Color Replacement (`color_replacment_shader.gdshader`):** Swap specific colors/palettes dynamically at runtime.
* **CRT TV (`crt_tv_shader.gdshader`):** Retro curved-screen distortion and phosphor glow effect.
* **Dissolve (`desolve_shader.gdshader`):** Smooth burn-out/burn-in dissolve transition.
* **Outline (`outline_shader.gdshader`):** Customizable sprite outline/silhouette highlight.
* **Scanlines (`Scanline_shader.gdshader`):** Classic arcade/monitor horizontal scanline overlay.
* **Water (`water_shader.gdshader`):** Animated 2D water surface/distortion effect.
* **Wind Trail (`wind_trail_shader.gdshader`):** Motion blur / wind trail effect for moving entities.

### ✨ Particle Systems & FX (`res://Scene/`)
* `leaf_particles.tscn` — Ambient falling/swirling leaves.
* `rain_particle.tscn` — 2D weather precipitation effect.
* `wind_trial_particle.tscn` — Directional wind/speed streaks.

### 🎮 Demo & Showcase Scenes
* `museum.tscn` / `game.tscn` — Interactive demonstration hubs to preview all shaders in action.
* Individual shader demo scenes (`*_shader.tscn`) for isolated testing.

---

## 🚀 How to Use in Your Project

### 1. Applying a Shader Material to a Node
1. Select your target **Sprite2D**, **CanvasItem**, or **ColorRect**.
2. In the Inspector, navigate to **CanvasItem > Material > Material**.
3. Create a new `ShaderMaterial` (or load an existing one).
4. Assign the desired `.gdshader` file from `res://Shaders/` to the **Shader** property.
5. Tweak shader parameters (speed, color, distortion, etc.) directly in the Inspector under **Shader Parameters**.

### 2. Fullscreen Screen-Reading Effects (CRT / Scanlines)
1. Add a **CanvasLayer** to your scene.
2. Add a **ColorRect** inside it and set **Layout > Full Rect**.
3. Attach a `ShaderMaterial` with `crt_tv_shader.gdshader` or `Scanline_shader.gdshader`.

### 3. Using Particle FX
* Simply drag any `.tscn` from `res://Scene/` (e.g., `leaf_particles.tscn`, `rain_particle.tscn`) into your scene tree.

---

## 📁 Project Structure

```text
res://
├── Asset/       # Textures, sprites, backgrounds, tilesets, and models
├── Scene/       # Ready-to-use effect scenes & test environments
├── Script/      # Helper controllers and demo showcase scripts
└── Shaders/     # Core .gdshader source files
