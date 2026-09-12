-- input.lua
-- Clavier, souris, pave tactile, gestes.
-- Doc : https://wiki.hypr.land/Configuring/Basics/Variables/ (section input)

hl.config({
    input = {
        kb_layout  = "fr",   -- AZERTY
        kb_variant = "",     -- "oss" pour majuscules accentuees, oe, etc.
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        numlock_by_default = true,
        follow_mouse       = 1,

        repeat_rate  = 40,
        repeat_delay = 400,

        sensitivity = 0, -- -1.0 a 1.0, 0 = aucune modification

        touchpad = {
            natural_scroll      = false,
            disable_while_typing = true,
            tap_to_click         = true,
        },
    },
})

-- Geste a trois doigts : changer d'espace de travail
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Reglage par peripherique.
-- Pour connaitre les noms exacts : hyprctl devices
-- Doc : https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
-- hl.device({
--     name        = "ma-souris",
--     sensitivity = -0.5,
-- })