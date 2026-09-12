-- env.lua
-- Variables d'environnement et permissions.
-- Doc : https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
--
-- Si tu passes un jour a uwsm pour lancer la session, ces variables
-- doivent aller dans ~/.config/uwsm/env a la place, pas ici.

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Force le backend Wayland natif plutot que XWayland quand c'est possible.
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Permissions
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Un changement ici demande un redemarrage complet de Hyprland,
-- il n'est pas applique a chaud (raison de securite).

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")