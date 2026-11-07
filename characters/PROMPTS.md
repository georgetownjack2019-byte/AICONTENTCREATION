# Prompt templates

For each character in the shot, attach **two** image references: the full sheet (body,
height, outfit) and the face close-up (face shape). Face drift is the most common failure;
the face close-up is what prevents it.

| Character | Full sheet (job) | Face close-up (media) |
|---|---|---|
| Kenji | `77791ae9-984c-479d-bba1-7395d3da963e` | `aac7c468-7ad5-42c2-b51f-489b11ca3d22` (`refs/kenji_face_ref.png`) |
| Yuki | `15415dfd-6ca1-47c3-9669-0600172b81ae` | `7fd54802-d02e-453d-b4b7-fb05bae11aec` (`refs/yuki_face_ref.png`) |

Duo shots: Kenji sheet, Kenji face, Yuki sheet, Yuki face (in that order), and say so in the prompt.

**Face-check before showing any still:** crop the character's face and compare it side by side
with the face close-up. Kenji must have a very round, chubby, plush-toy head, a SHORT small
muzzle, a tiny mouth, big round eyes, wide cream cheek fluff, and large cream eyebrow dots.
Reject any long or realistic dog snout, narrow head, fox or wolf look, or long neck.

Keep the **LOCK** sentences word-for-word. Only edit the `[...]` parts.

## LOCK sentences (paste unchanged)
**Kenji:** Kenji is the same character as the Kenji reference sheet and face close-up:
identical face, very round chubby plush-toy head, short small muzzle, tiny mouth, wide cream
cheek fluff, large cream eyebrow dots, bright red-orange Shiba Inu coat, cream cheeks/muzzle/chest, cream eyebrow dots, pointed
upright ears, fluffy curled tail, big round brown eyes, tall lean broad-shouldered body,
clearly taller than Yuki. His coat is a deeper red-orange than Yuki's.

**Yuki:** Yuki is the same character as the Yuki reference sheet: identical face, golden
honey-orange Shiba Inu coat lighter than Kenji's, cream cheeks/muzzle/chest, cream eyebrow
dots, pointed upright ears, fluffy curled tail, almond amber-brown eyes with lashes,
petite slim body, about a head shorter than Kenji. No ribbon, bow or hair accessory
unless the scene asks for one.

**Style:** Stylized 3D animated-feature-film cartoon render, soft stylized fur,
expressive faces, soft cinematic lighting, vertical 9:16. Muted desaturated palette only (ivory, cream, oatmeal, camel, taupe, soft grey,
muted navy, soft sage, chocolate brown); no saturated or bright colours. Not photoreal, no human hair
unless stated, no text, no watermark, no brand logos on props or clothing.

## Scene: duo
> [Kenji LOCK] [Yuki LOCK] Scene: [setting]. Kenji wears [outfit]. Yuki wears [outfit].
> Kenji is [action + expression]. Yuki is [action + expression]. [Shot: medium-wide,
> both full body, side by side]. [Style]

## Scene: solo
> [Name LOCK] Scene: [setting]. [Name] wears [outfit][, optional hair accessory].
> [Action + expression]. [Shot: close-up / medium / full body]. [Style]

## Costume/insert cutaway (white-background inserts)
> [Name LOCK] [Name] dressed as [costume], full body, standing pose, pure white
> background, centered, [expression]. [Style]

## Outfit ideas: everyday (trend shorts)
| Scene | Kenji | Yuki |
|---|---|---|
| Home / lazy day | Grey hoodie, sweatpants, socks | Oversized tee, bike shorts, claw clip |
| Bedtime | Plain tee, plaid PJ pants | Matching soft PJ set |
| Work (hybrid) | Navy quarter-zip, chinos | Beige knit sweater, straight jeans |
| Gym / Pilates | Black tee, shorts, trainers | Ribbed workout set, grip socks |
| Errands / weekend | Denim jacket, white tee, jeans | Cardigan, tank top, jeans, tote bag |
| Going out | Black overshirt, dark jeans | Simple slip dress, cropped jacket |

## Outfit ideas: old money (drama series)
| Theme | Kenji | Yuki |
|---|---|---|
| Office | Charcoal flannel suit, ivory shirt, taupe knit tie | Oatmeal tweed blazer, cream silk blouse, camel trousers, pearls |
| Country club | Camel overcoat, cream turtleneck, taupe trousers, suede loafers | Cashmere cardigan on shoulders, silk blouse, pleated midi skirt, ballet flats |
| Pilates/active | Grey quarter-zip, cream joggers, white leather sneakers | Oatmeal ribbed Pilates set, cream grip socks, matcha (optional: claw clip) |
| Date night | Muted navy blazer, ivory open-collar shirt, grey trousers | Champagne satin slip dress, cream cashmere wrap, pearl drops |
| Weekend | Cable-knit sweater over shoulders, oxford shirt, chinos | Striped cream/navy Breton top, white jeans, straw tote |
| Winter | Grey herringbone coat, cashmere scarf, leather gloves | Long camel coat, cashmere scarf (optional: cream knit beret) |
| Tennis | Cream cable tennis sweater, white shorts | Pleated white tennis skirt, cream polo, visor |
