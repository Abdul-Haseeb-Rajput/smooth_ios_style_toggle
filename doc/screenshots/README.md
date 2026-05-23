# Screenshots for README & pub.dev

The example app lists **many toggles** on one scrollable screen (setState, controller, text inside thumb, large/compact, disabled, etc.). You need **four PNGs** — not one per layout type, but **two scroll positions for OFF** and **two for ON**.

## File names (exact)

| File name | Content |
| --------- | ------- |
| `toggle_demo_off_1.png` | Example app with toggles mostly **OFF** — top / first scroll |
| `toggle_demo_off_2.png` | Same **OFF** state — scrolled down to show more rows |
| `toggle_demo_on_1.png` | Example app with toggles mostly **ON** — top / first scroll |
| `toggle_demo_on_2.png` | Same **ON** state — scrolled down to show more rows |

Before capturing **ON** shots, turn the interactive toggles on in the app (sections 1–6, 10). Leave **Disabled** and **No labels** as designed.

## Tips

- Same device theme for all four (light or dark).
- Crop to the phone frame or the list area; keep width similar across shots.

## Legacy files (delete if present)

- `toggle_default_off.jpeg`, `toggle_default_on.jpeg`
- `toggle_track_labels_*.png`, `toggle_thumb_inside_*.png` (old naming from an earlier README draft)

## After adding files

```bash
git add doc/screenshots/*.png
git commit -m "Add example app screenshots for v0.2.0"
```
