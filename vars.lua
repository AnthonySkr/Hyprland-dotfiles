-- vars.lua
-- Applications et modificateur principal.
-- C'est le premier fichier a editer : change une valeur ici et tous
-- les raccourcis suivent.
--
-- Un `local` ne franchit pas la frontiere d'un fichier. Ce module
-- renvoie une table, que les autres recuperent avec :
--     local v = require("vars")
-- require() met en cache : le fichier n'est lu qu'une fois.

return {
  mod = "SUPER",   -- modificateur principal (touche Windows)

  terminal    = "kitty",
  browser     = "firefox",
  fileManager = "dolphin",
  editor      = "code",

  -- Lanceur. Walker a besoin du demon elephant (lance dans autostart.lua).
  menu = "walker",

  -- Mode dmenu de walker : utilise par le cheatsheet et les menus maison.
  dmenu = "walker --dmenu",
}