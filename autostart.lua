-- autostart.lua
-- Programmes lances avec la session.
-- Doc : https://wiki.hypr.land/Configuring/Basics/Autostart/
--
-- "hyprland.start" est emis une fois, au lancement.
--
-- elephant est le demon qui alimente walker (applications, calculatrice,
-- mode dmenu). Sans lui, walker ne repond pas.

hl.on("hyprland.start", function()
    hl.exec_cmd("elephant")            -- backend de walker, doit tourner en permanence
    hl.exec_cmd("quickshell")          -- barre

    -- Decommente au fur et a mesure que tu installes ces outils :
    -- hl.exec_cmd("hyprpaper")        -- fond d'ecran
    -- hl.exec_cmd("hypridle")         -- mise en veille
    -- hl.exec_cmd("mako")             -- notifications
    -- hl.exec_cmd("nm-applet --indicator")
end)