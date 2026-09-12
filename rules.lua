-- rules.lua
-- Regles de fenetres, de calques et d'espaces de travail.
-- Doc : https://wiki.hypr.land/Configuring/Basics/Window-Rules/
--       https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
--
-- hl.window_rule() et hl.layer_rule() renvoient une poignee :
-- :set_enabled(false) neutralise une regle sans la supprimer.

---- CORRECTIFS ----

local suppressMaximizeRule = hl.window_rule({
    -- Ignore les demandes de maximisation venant des applications.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Corrige des problemes de glisser-deposer sous XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

---- FENETRES FLOTTANTES ----

-- Les boites de dialogue et utilitaires flottent plutot que de
-- deranger le pavage.
hl.window_rule({
    name  = "float-dialogs",
    match = { title = "^(Open File|Save File|Choose Files|Ouvrir|Enregistrer)" },
    float = true,
})

hl.window_rule({
    name  = "float-utilities",
    match = { class = "^(pavucontrol|blueman-manager|nm-connection-editor)$" },
    float = true,
    size  = "800 600",
})

---- ESTHETIQUE ----

-- Pas de flou derriere le lanceur : c'est deja une surface opaque,
-- le flou ne ferait que couter du GPU.
hl.layer_rule({
    name    = "walker-blur",
    match   = { namespace = "^walker$" },
    blur    = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name    = "quickshell-no-anim",
    match   = { namespace = "^quickshell" },
    no_anim = true,
})

---- SMART GAPS ----

-- Pas d'espacement ni de bordure quand il n'y a qu'une fenetre.
-- Les quatre blocs vont ensemble : decommente-les tous ou aucun.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })