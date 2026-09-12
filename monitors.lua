-- monitors.lua
-- Ecrans.
-- Doc : https://wiki.hypr.land/Configuring/Basics/Monitors/
--
-- output = "" est un fourre-tout : la regle s'applique a tout ecran
-- non decrit explicitement. Tant que l'autodetection convient, il n'y
-- a rien a ajouter.
--
-- Pour lister tes ecrans et leurs modes :
--     hyprctl monitors

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- Exemple pour un poste fixe a deux ecrans, a adapter :
-- hl.monitor({ output = "DP-1",  mode = "2560x1440@144", position = "0x0",    scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "2560x0", scale = 1 })