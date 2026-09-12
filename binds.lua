-- binds.lua
-- Raccourcis clavier.
-- Doc : https://wiki.hypr.land/Configuring/Basics/Binds/
--       https://wiki.hypr.land/Configuring/Basics/Dispatchers/
--
-- REGLE ABSOLUE DE CE FICHIER : tout raccourci passe par bind(), qui
-- exige une description. Le cheatsheet (SUPER + K) est genere depuis
-- `hyprctl binds` : un raccourci sans description est un raccourci
-- invisible dans l'aide.
--
-- Note AZERTY : la rangee du haut ne produit pas de chiffres. Les
-- espaces de travail sont donc lies aux noms de keysyms (ampersand,
-- eacute...) et non a "1", "2". Ne pas utiliser code:10 a code:19 :
-- ca marchait en hyprlang, mais en Lua un bug ouvert fait que
-- hl.bind("code:N", ...) se declenche aussi sur tout evenement dont
-- le keysym est inconnu.

local v = require("vars")

-- Wrapper : la description n'est pas optionnelle.
local function bind(keys, dsp, desc, flags)
    flags = flags or {}
    flags.description = desc
    hl.bind(keys, dsp, flags)
end

local m = v.mod

---- APPLICATIONS ----

bind(m .. " + RETURN",         hl.dsp.exec_cmd(v.terminal),    "Terminal")
bind(m .. " + SHIFT + RETURN", hl.dsp.exec_cmd(v.browser),     "Navigateur")
bind(m .. " + E",              hl.dsp.exec_cmd(v.fileManager), "Gestionnaire de fichiers")
bind(m .. " + N",              hl.dsp.exec_cmd(v.editor),      "Editeur")

---- MENUS ----

bind(m .. " + SPACE", hl.dsp.exec_cmd(v.menu),
     "Lanceur d'applications")
bind(m .. " + K",     hl.dsp.exec_cmd("~/.config/hypr/scripts/keybindings"),
     "Afficher les raccourcis")

---- SESSION ----

-- hyprshutdown est prefere a hl.dsp.exit() : il laisse le
-- gestionnaire de session se terminer proprement.
bind(m .. " + SHIFT + Q", hl.dsp.exec_cmd(
     "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"),
     "Quitter la session")
bind(m .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"),
     "Recharger la configuration")

---- FENETRES ----

bind(m .. " + W", hl.dsp.window.close(),
     "Fermer la fenetre")
bind(m .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
     "Plein ecran")
bind(m .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
     "Maximiser")
bind(m .. " + V", hl.dsp.window.float({ action = "toggle" }),
     "Fenetre flottante")
bind(m .. " + P", hl.dsp.window.pseudo(),
     "Mode pseudo-pave")
bind(m .. " + T", hl.dsp.layout("togglesplit"),
     "Pivoter la separation")

---- FOCUS ----

-- Les directions s'ecrivent en toutes lettres : "left", pas "l".
-- Fleches et hjkl mappent les memes actions, choisis ce que tu preferes.
local dirs = {
    { key = "left",  arrow = "left",  dir = "left",  label = "gauche" },
    { key = "H",     arrow = "left",  dir = "left",  label = "gauche" },
    { key = "right", arrow = "right", dir = "right", label = "droite" },
    { key = "L",     arrow = "right", dir = "right", label = "droite" },
    { key = "up",    arrow = "up",    dir = "up",    label = "haut" },
    { key = "K",     arrow = "up",    dir = "up",    label = "haut" },
    { key = "down",  arrow = "down",  dir = "down",  label = "bas" },
    { key = "J",     arrow = "down",  dir = "down",  label = "bas" },
}

for _, d in ipairs(dirs) do
    bind(m .. " + " .. d.key,
         hl.dsp.focus({ direction = d.dir }),
         "Focus vers la " .. d.label)
    bind(m .. " + SHIFT + " .. d.key,
         hl.dsp.window.move({ direction = d.dir }),
         "Deplacer la fenetre vers la " .. d.label)
end

---- ESPACES DE TRAVAIL ----

-- Keysyms de la rangee du haut en AZERTY, bureaux 1 a 10.
local ws_keys = {
    "ampersand", "eacute", "quotedbl", "apostrophe", "parenleft",
    "minus", "egrave", "underscore", "ccedilla", "agrave",
}

for i, key in ipairs(ws_keys) do
    bind(m .. " + " .. key,
         hl.dsp.focus({ workspace = i }),
         "Bureau " .. i)
    bind(m .. " + SHIFT + " .. key,
         hl.dsp.window.move({ workspace = i }),
         "Envoyer au bureau " .. i)
end

bind(m .. " + S",         hl.dsp.workspace.toggle_special("magic"),
     "Bloc-notes")
bind(m .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }),
     "Envoyer au bloc-notes")

bind(m .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }),
     "Bureau suivant")
bind(m .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }),
     "Bureau precedent")

---- SOURIS ----

bind(m .. " + mouse:272", hl.dsp.window.drag(),
     "Deplacer la fenetre a la souris", { mouse = true })
bind(m .. " + mouse:273", hl.dsp.window.resize(),
     "Redimensionner a la souris", { mouse = true })

---- CAPTURES D'ECRAN ----
-- Necessite grim, slurp et wl-clipboard :
--     sudo dnf install grim slurp wl-clipboard

bind("PRINT", hl.dsp.exec_cmd("grim - | wl-copy"),
     "Capture de l'ecran")
bind("SHIFT + PRINT", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"),
     "Capture d'une zone")

---- MULTIMEDIA ----
-- locked : fonctionne aussi ecran verrouille
-- repeating : se repete si la touche reste enfoncee

bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
     "Volume +", { locked = true, repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
     "Volume -", { locked = true, repeating = true })
bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
     "Couper le son", { locked = true })
bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
     "Couper le micro", { locked = true })
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
     "Luminosite +", { locked = true, repeating = true })
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
     "Luminosite -", { locked = true, repeating = true })

-- Necessite playerctl
bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       "Piste suivante",   { locked = true })
bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   "Piste precedente", { locked = true })
bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), "Lecture / pause",  { locked = true })
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), "Lecture / pause",  { locked = true })