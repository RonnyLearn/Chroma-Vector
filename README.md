# Chroma Vector

A Minecraft shaderpack for Iris and OptiFine that turns the world into glowing outlines on a black screen. Every line is coloured with a smooth animated rainbow, with an optional neon glow.

## Features

| Section | What you can change |
|---|---|
| Line colours | Rainbow speed, starting hue, hue range, saturation, brightness, pattern, or one solid colour |
| Neon glow | On / off, circle or stripe shape, glow strength, halo size, white core, tube flicker |
| Line shape | Edge sensitivity by colour, depth and angle, line thickness, distant line fade |
| Screen | Small glow, afterglow, screen curvature, background tint, scanlines, scan band |

Presets: Standard, Rainbow, Rainbow Neon, Neon, Fire, Classic. The settings menu is in English and Russian.

## Download

Get the shaderpack from the official page: [modrinth.com/shader/chroma-vector](https://modrinth.com/shader/chroma-vector)

## Source code

| Path | Contents |
|---|---|
| [shaders/composite.fsh](shaders/composite.fsh) | Edge detection |
| [shaders/composite1.fsh](shaders/composite1.fsh) | Line colour, glow, afterglow |
| [shaders/composite2.fsh](shaders/composite2.fsh), [composite3.fsh](shaders/composite3.fsh) | Neon halo blur |
| [shaders/final.fsh](shaders/final.fsh) | Neon mix, screen curvature, scanlines |
| [shaders/lib](shaders/lib) | Settings, rainbow, shared gbuffers code |
| [shaders/shaders.properties](shaders/shaders.properties) | Menu layout and presets |
| [shaders/lang](shaders/lang) | English and Russian option names |

## License

All rights reserved. See [LICENSE](LICENSE).
