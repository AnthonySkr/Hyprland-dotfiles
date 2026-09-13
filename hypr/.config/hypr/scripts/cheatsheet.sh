#!/usr/bin/env bash
# Cheatsheet des raccourcis Hyprland.
# La liste est generee a la volee depuis `hyprctl binds -j` : toute modification
# de keybind.lua est donc refletee des le prochain affichage, sans rien regenerer.
set -euo pipefail

CLASS="hypr-cheatsheet"
OUT="${XDG_RUNTIME_DIR:-/tmp}/hypr-cheatsheet.txt"

# Toggle : si la fenetre est deja ouverte, on la ferme.
# Sous la config Lua, `hyprctl dispatch` attend une expression Lua et non la
# syntaxe shell historique -- d'ou l'appel a hl.dsp plutot qu'a `closewindow`.
if hyprctl clients -j | jq -e --arg c "$CLASS" 'any(.[]; .class == $c)' >/dev/null; then
    hyprctl dispatch "hl.dsp.window.close({ match = { class = \"${CLASS}\" } })" >/dev/null
    exit 0
fi

hyprctl binds -j | jq -r '
    def esc: "";

    # Clavier AZERTY : les keysyms de la rangee du haut sont reaffiches sous
    # leur chiffre, et les noms de touches techniques rendus lisibles.
    def pretty_key:
        {
            "ampersand": "1", "eacute": "2", "quotedbl": "3", "apostrophe": "4",
            "parenleft": "5", "minus": "6", "egrave": "7", "underscore": "8",
            "ccedilla": "9", "agrave": "0",
            "mouse:272": "Clic gauche", "mouse:273": "Clic droit",
            "mouse_down": "Molette bas", "mouse_up": "Molette haut",
            "RETURN": "Entree", "PRINT": "Impr. ecran", "tab": "Tab",
            "left": "Gauche", "right": "Droite", "up": "Haut", "down": "Bas",
            "XF86AudioPlay": "Play/Pause", "XF86AudioNext": "Piste suivante",
            "XF86AudioPrev": "Piste precedente",
            "XF86AudioRaiseVolume": "Volume +", "XF86AudioLowerVolume": "Volume -"
        } as $m | $m[.] // .;

    def mods:
        [ (if (.modmask / 64 | floor) % 2 == 1 then "SUPER" else empty end),
          (if (.modmask /  8 | floor) % 2 == 1 then "ALT"   else empty end),
          (if (.modmask /  4 | floor) % 2 == 1 then "CTRL"  else empty end),
          (if (.modmask      | floor) % 2 == 1 then "SHIFT" else empty end) ]
        | join(" + ");

    def pad($n): . + (" " * ([$n - length, 1] | max));

    [ .[]
      | select(.has_description and (.description | length > 0))
      | { mods: mods, key: (.key | pretty_key), desc: .description, m: .modmask }
    ]
    | group_by(.m)
    | sort_by(.[0].m)
    | map(
        ( esc + "[1;36m"
          + (if .[0].mods == "" then "Touches multimedia" else .[0].mods end)
          + esc + "[0m" ),
        ( sort_by(.desc)[]
          | "  " + esc + "[1;33m" + (.key | pad(22)) + esc + "[0m" + .desc ),
        ""
      )
    | .[]
' > "$OUT"

kitty --class "$CLASS" --title "Raccourcis Hyprland" \
      -o confirm_os_window_close=0 \
      -- sh -c "less -R '$OUT' || { cat '$OUT'; read -r _; }"
