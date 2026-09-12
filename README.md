# Config Hyprland — Fedora 44 · Hyprland 0.56 (Lua) · AZERTY

Base complète et modulaire : pas de décorations,
espacements serrés, angles nets, tout au clavier, et une aide des raccourcis
générée depuis la config elle-même.

Conçue pour être modifiée : chaque fichier a un rôle unique, et les deux
fichiers que tu toucheras le plus (`vars.lua`, `theme.lua`) ne contiennent
aucune logique.

---

## Arborescence

```
~/.config/hypr/
├── hyprland.lua      point d'entrée — ordre de chargement uniquement
├── vars.lua          applications et modificateur principal
├── theme.lua         palette et géométrie
├── env.lua           variables d'environnement, permissions
├── monitors.lua      écrans
├── input.lua         clavier, souris, pavé tactile, gestes
├── look.lua          apparence, décoration, layouts
├── animations.lua    courbes et animations
├── rules.lua         règles de fenêtres et de calques
├── binds.lua         raccourcis clavier
├── autostart.lua     programmes lancés avec la session
└── scripts/
    └── keybindings   cheatsheet (SUPER + K)

~/.config/quickshell/
└── shell.qml         barre du haut
```

Fichiers à plat, pas de sous-dossier : c'est la forme que documente le
fichier d'exemple de Hyprland (`require("myColors")`).

---

## Les deux fichiers à connaître

**`vars.lua`** — terminal, navigateur, éditeur, lanceur, modificateur.
Change `terminal = "kitty"` et tous les raccourcis concernés suivent.

**`theme.lua`** — couleurs et géométrie. Aucune couleur n'est écrite en dur
ailleurs : `look.lua` lit ses valeurs ici. Pour reskinner la config entière,
c'est le seul fichier à toucher.

### Pourquoi une table plutôt que des `local`

Un `local` ne franchit pas la frontière d'un fichier. `vars.lua` et
`theme.lua` renvoient une table, que les autres récupèrent :

```lua
local v = require("vars")
hl.bind(v.mod .. " + RETURN", hl.dsp.exec_cmd(v.terminal), { … })
```

`require` met en cache : appelé depuis cinq fichiers, il ne lit `vars.lua`
qu'une fois.

---

## Installation

### Paquets

```bash
# Lanceur (walker a besoin d'elephant pour fonctionner)
sudo dnf copr enable errornointernet/walker
sudo dnf install walker elephant

# Barre
sudo dnf copr enable errornointernet/quickshell
sudo dnf install quickshell

# Outils utilisés par les raccourcis
sudo dnf install jq grim slurp wl-clipboard playerctl brightnessctl
```

### Mise en place

```bash
cp -r ~/.config/hypr ~/.config/hypr.bak
cp -r hypr/*        ~/.config/hypr/
mkdir -p ~/.config/quickshell && cp quickshell/shell.qml ~/.config/quickshell/
chmod +x ~/.config/hypr/scripts/keybindings

hyprctl reload && hyprctl configerrors
```

### Vérification

```bash
# Tous les raccourcis ont-ils une description ?
hyprctl binds -j | jq '[.[] | select(.description == "")] | length'   # doit valoir 0

# Le cheatsheet sort-il quelque chose de lisible ?
~/.config/hypr/scripts/keybindings --print
```

### Retour arrière

```bash
rm -rf ~/.config/hypr && mv ~/.config/hypr.bak ~/.config/hypr && hyprctl reload
```

---

## Le cheatsheet

`SUPER + K`. Il ne maintient aucune liste : il lit `hyprctl binds`, garde les
raccourcis qui portent une description, décode le masque de modificateurs et
envoie le tout dans `walker --dmenu`.

Conséquence directe : **un raccourci sans description est invisible dans
l'aide**. C'est pourquoi `binds.lua` passe tout par un wrapper local qui
rend la description obligatoire :

```lua
local function bind(keys, dsp, desc, flags)
    flags = flags or {}
    flags.description = desc
    hl.bind(keys, dsp, flags)
end
```

Ajoute un raccourci par `bind()`, il se documente tout seul.

`keybindings --print` écrit sur la sortie standard, pratique pour chercher :

```bash
~/.config/hypr/scripts/keybindings --print | grep -i bureau
```

Le script retraduit aussi les keysyms X11 en caractères lisibles : `ampersand`
devient `&`, `mouse:272` devient `clic gauche`.

---

## Raccourcis principaux

| Touches | Action |
|---|---|
| `SUPER + Entrée` | Terminal |
| `SUPER + Espace` | Lanceur |
| `SUPER + K` | Afficher les raccourcis |
| `SUPER + W` | Fermer la fenêtre |
| `SUPER + F` | Plein écran |
| `SUPER + V` | Fenêtre flottante |
| `SUPER + ← ↑ ↓ →` ou `hjkl` | Déplacer le focus |
| `SUPER + Shift + ← ↑ ↓ →` | Déplacer la fenêtre |
| `SUPER + & é " ' (` … | Bureaux 1 à 10 |
| `SUPER + Shift + & é " '` … | Envoyer la fenêtre au bureau |
| `SUPER + S` | Bloc-notes (espace spécial) |
| `SUPER + Ctrl + R` | Recharger la configuration |
| `SUPER + Shift + Q` | Quitter la session |

La liste complète est dans le cheatsheet, par construction toujours à jour.

---

## Spécificités AZERTY

La rangée du haut ne produit pas de chiffres mais `& é " ' ( - è _ ç à`.
Les bureaux sont donc liés aux **noms de keysyms**, pas aux chiffres :

```lua
local ws_keys = {
    "ampersand", "eacute", "quotedbl", "apostrophe", "parenleft",
    "minus", "egrave", "underscore", "ccedilla", "agrave",
}
```

**Ne pas utiliser `code:10` à `code:19`.** C'est la solution qu'on trouve
partout dans les configs françaises, elle marchait en hyprlang, mais en Lua
un bug ouvert fait que `hl.bind("code:N", …)` se déclenche aussi sur tout
événement dont le keysym est inconnu.

Avec `SHIFT`, Hyprland résout sur le keysym non modifié : `SUPER + SHIFT +
ampersand` fonctionne, pas besoin de table séparée.

---

## Pièges vérifiés au passage

**Beaucoup d'appels de dispatcher invalides renvoient « ok » au lieu de lever
une erreur.** `hyprctl configerrors` peut donc être propre alors qu'un
raccourci ne fait rien. La vraie vérification, c'est `hyprctl binds` et
l'essai réel.

**Les directions de focus s'écrivent en toutes lettres** : `direction = "left"`,
pas `"l"`.

**`hl.bind`, `hl.window_rule` et `hl.layer_rule` renvoient une poignée.**
`:set_enabled(false)` neutralise sans supprimer la ligne.

**Quickshell se compile contre les API privées de Qt.** Une mise à jour Qt de
Fedora peut casser la barre (`undefined symbol`) jusqu'au rebuild du COPR.
C'est récurrent, pas exotique.

**Walker sans elephant ne répond pas.** Le démon est lancé dans
`autostart.lua` ; s'il n'est pas là, le lanceur s'ouvre vide.

**Les configs trouvées en ligne sont presque toutes en hyprlang (`.conf`).**
Elles ne se copient pas telles quelles en 0.56. Références en Lua :
`/usr/share/hypr/hyprland.lua`, la page *Lua code snippets* du wiki, et les
pages wiki 0.54 pour relire l'ancienne syntaxe.

---

## Ce qui n'est pas fini

**`quickshell/shell.qml`** est une base minimale — espaces de travail et
horloge. C'est du QML, une application à part entière, et je ne l'ai pas
exécutée : à vérifier contre ta version de Quickshell avec
`quickshell -p ~/.config/quickshell/shell.qml`, qui affiche les erreurs.
Si l'API a bougé, les noms à contrôler sont `Variants`, `PanelWindow`,
`Hyprland.workspaces` et `SystemClock`.

**Pas de configuration walker.** Le mode dmenu utilisé par le cheatsheet
fonctionne sans config. Le thème de walker se règle séparément.

À faire ensuite, par ordre d'intérêt : fond d'écran (`hyprpaper`),
verrouillage et mise en veille (`hyprlock` + `hypridle`), notifications
(`mako` ou `swaync`), puis étoffer la barre.