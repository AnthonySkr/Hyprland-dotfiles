-- look.lua
-- Apparence generale, decoration, layouts.
-- Doc : https://wiki.hypr.land/Configuring/Basics/Variables/
--
-- Aucune couleur ni valeur d'espacement n'est ecrite en dur ici :
-- tout vient de theme.lua. Pour changer le rendu, edite theme.lua.

local t = require("theme")
local c = t.colors
local g = t.geometry

hl.config({
    general = {
        gaps_in  = g.gaps_in,
        gaps_out = g.gaps_out,

        border_size = g.border_size,

        col = {
            -- Degrade sur la fenetre active : c'est le seul element
            -- visuel fort de la config, tout le reste est sobre.
            active_border = {
                colors = { t.rgba(c.accent), t.rgba(c.accent_2) },
                angle  = 45,
            },
            inactive_border = t.rgba(c.bg_light),
        },

        resize_on_border = true,   -- redimensionner en tirant sur la bordure
        allow_tearing    = false,  -- lire la doc Tearing avant d'activer

        layout = "dwindle",
    },

    decoration = {
        rounding       = g.rounding,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.95,   -- distingue la fenetre active sans bruit

        shadow = {
            enabled = false,       -- angles nets, pas d'ombre
        },

        blur = {
            enabled     = true,
            size        = 4,
            passes      = 2,
            new_optimizations = true,
            vibrancy    = 0.17,
        },
    },

    animations = {
        enabled = true,   -- le detail est dans animations.lua
    },
})

-- Layout dwindle (celui selectionne ci-dessus)
-- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        preserve_split = true,
        smart_split    = false,
        smart_resizing = true,
    },
})

-- Layout master, disponible si tu veux basculer un jour
-- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})

-- Layout scrolling
-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,     -- pas de fond par defaut
        disable_hyprland_logo   = true,  -- pas de logo
        disable_splash_rendering = true,
        focus_on_activate       = true,  -- utile avec les lanceurs
    },
})